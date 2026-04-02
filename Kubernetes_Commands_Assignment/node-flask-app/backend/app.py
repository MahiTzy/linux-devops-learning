from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route("/submit", methods=["POST"])
def submit():
    data = request.json
    print("Received:", data)
    return jsonify({"message": "Data received successfully",
                   "Name": data.name})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
