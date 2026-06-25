import sqlite3

# ==========================
# DATABASE CONNECTION
# ==========================

def get_db():
    conn = sqlite3.connect("tasks.db")

    # allows:
    # row["subject"]
    # row["completed"]
    conn.row_factory = sqlite3.Row

    return conn


# ==========================
# INITIALIZE DATABASE
# ==========================

def init_db():
    conn = sqlite3.connect("tasks.db")
    cursor = conn.cursor()

    # TASKS TABLE
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        subject TEXT NOT NULL,
        topic TEXT NOT NULL,
        completed INTEGER DEFAULT 0,
        date TEXT
    )
    """)

    # USERS TABLE
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT UNIQUE,
        password TEXT
    )
    """)

    conn.commit()
    conn.close()