from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from database import get_db, init_db

app = FastAPI()

# ---------------- CORS ----------------
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ---------------- INIT DATABASE ----------------
init_db()

# ---------------- MODELS ----------------

class User(BaseModel):
    email: str
    password: str


class TaskCreate(BaseModel):
    subject: str
    topic: str
    completed: bool = False
    date: str | None = None


# ==================================================
# AUTH ROUTES
# ==================================================

@app.post("/register")
def register(user: User):
    conn = get_db()
    cursor = conn.cursor()

    cursor.execute(
        """
        INSERT INTO users (email, password)
        VALUES (?, ?)
        """,
        (user.email, user.password),
    )

    conn.commit()
    conn.close()

    return {"message": "User registered successfully"}


@app.post("/login")
def login(user: User):
    conn = get_db()
    cursor = conn.cursor()

    cursor.execute(
        """
        SELECT * FROM users
        WHERE email=? AND password=?
        """,
        (user.email, user.password),
    )

    result = cursor.fetchone()

    conn.close()

    if result:
        return {
            "success": True,
            "message": "Login successful"
        }

    return {
        "success": False,
        "message": "Invalid credentials"
    }


# ==================================================
# TASK ROUTES
# ==================================================

@app.get("/tasks")
def get_tasks():
    conn = get_db()
    cursor = conn.cursor()

    cursor.execute(
        """
        SELECT id, subject, topic, completed
        FROM tasks
        """
    )

    rows = cursor.fetchall()

    conn.close()

    return [
        {
            "id": row[0],
            "subject": row[1],
            "topic": row[2],
            "completed": bool(row[3]),
            "date": None,
        }
        for row in rows
    ]


@app.post("/tasks")
def add_task(task: TaskCreate):
    conn = get_db()
    cursor = conn.cursor()

    cursor.execute(
        """
        INSERT INTO tasks
        (subject, topic, completed)
        VALUES (?, ?, ?)
        """,
        (
            task.subject,
            task.topic,
            1 if task.completed else 0,
        ),
    )

    conn.commit()
    conn.close()

    return {
        "success": True,
        "message": "Task added"
    }


@app.put("/tasks/{task_id}")
def toggle_task(task_id: int):
    conn = get_db()
    cursor = conn.cursor()

    cursor.execute(
        """
        SELECT completed
        FROM tasks
        WHERE id=?
        """,
        (task_id,),
    )

    row = cursor.fetchone()

    if row is None:
        conn.close()
        return {
            "success": False,
            "message": "Task not found"
        }

    current = row[0]

    new_value = 0 if current == 1 else 1

    cursor.execute(
        """
        UPDATE tasks
        SET completed=?
        WHERE id=?
        """,
        (new_value, task_id),
    )

    conn.commit()
    conn.close()

    return {
        "success": True,
        "completed": bool(new_value)
    }


@app.delete("/tasks/{task_id}")
def delete_task(task_id: int):
    conn = get_db()
    cursor = conn.cursor()

    cursor.execute(
        """
        DELETE FROM tasks
        WHERE id=?
        """,
        (task_id,),
    )

    conn.commit()
    conn.close()

    return {
        "success": True,
        "message": "Task deleted"
    }




# ==================================================
# ANALYTICS
# ==================================================

@app.get("/analytics")
def analytics():
    conn = get_db()
    cursor = conn.cursor()

    cursor.execute("SELECT COUNT(*) FROM tasks")
    total = cursor.fetchone()[0]

    cursor.execute(
        """
        SELECT COUNT(*)
        FROM tasks
        WHERE completed = 1
        """
    )

    completed = cursor.fetchone()[0]

    progress = 0
    if total > 0:
        progress = completed / total

    score = int(progress * 100)

    insights = []

    if total == 0:
        insights.append(
            "Start adding tasks to begin your journey 🚀"
        )

    elif score < 40:
        insights.append(
            "Your productivity is low. Try Pomodoro sessions ⏱"
        )

    elif score < 70:
        insights.append(
            "Good progress. Stay consistent 🔥"
        )

    else:
        insights.append(
            "Excellent productivity! Keep going 💪"
        )

    conn.close()

    return {
        "total_tasks": total,
        "completed_tasks": completed,
        "pending_tasks": total - completed,
        "progress": progress,
        "score": score,
        "insights": insights,
    }