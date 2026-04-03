from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route("/", methods=["GET"])
def home():
    return jsonify({
        "message": "Flask backend is running successfully"
    })


@app.route("/submit", methods=["POST"])
def submit():
    data = request.json
    print("Received:", data)

    return jsonify({
        "message": "Data received successfully",
        "name": data.get("name"),
        "grade": data.get("grade")
    })


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
