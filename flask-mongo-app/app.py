from flask import Flask, jsonify, render_template, request, redirect
from pymongo import MongoClient
import json

app = Flask(__name__)

# MongoDB Atlas connection
client = MongoClient("mongodb+srv://mohitofficial229_db_user:U33APBJdn9dGa1NF@cluster0.s4bwb7x.mongodb.net/?appName=Cluster0")
db = client["student_db"]
collection = db["students"]

# ---------------- Task 1 ----------------
@app.route("/api")
def api():
    with open("data.json", "r") as file:
        data = json.load(file)
    return jsonify(data)

# ---------------- Task 2 ----------------
@app.route("/", methods=["GET", "POST"])
def form():
    if request.method == "POST":
        try:
            name = request.form.get("name")
            grade = request.form.get("grade")

            collection.insert_one({
                "name": name,
                "grade": grade
            })

            return redirect("/success")

        except Exception as e:
            return render_template("frontend/form.html", error=str(e))

    return render_template("form.html")

@app.route("/success")
def success():
    return render_template("success.html")

if __name__ == "__main__":
    app.run(debug=True)