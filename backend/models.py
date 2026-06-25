from pydantic import BaseModel

class Task(BaseModel):
    subject: str
    topic: str
    completed: bool = False