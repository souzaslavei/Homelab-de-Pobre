from flask import Flask, jsonify, send_from_directory
import subprocess
import os
from pathlib import Path

app = Flask(__name__)

SERVER=str(Path(__file__).resolve().parent.parent)


def run_script(script):
    try:
        result = subprocess.check_output(
            ["bash", script],
            text=True
        )

        data = {}

        for line in result.splitlines():
            if "=" in line:
                key, value = line.split("=", 1)
                data[key] = value

        return data

    except Exception as e:
        return {
            "error": str(e)
        }


@app.route("/")
def index():
    return send_from_directory(
        "assets",
        "index.html"
    )


@app.route("/css/<path:file>")
def css(file):
    return send_from_directory(
        "assets/css",
        file
    )


@app.route("/js/<path:file>")
def js(file):
    return send_from_directory(
        "assets/js",
        file
    )


@app.route("/api/status")
def status():
    return jsonify(
        run_script(
            f"{SERVER}/web/api/status.sh"
        )
    )



@app.route("/api/identidade")
def identidade():
    config = {}
    path = f"{SERVER}/configuracoes/identidade.conf"

    try:
        with open(path) as file:
            for line in file:
                if "=" in line and not line.startswith("#"):
                    key, value = line.strip().split("=", 1)
                    config[key] = value.replace('"', '')
    except Exception as e:
        config["error"] = str(e)

    return jsonify(config)



@app.route("/api/enderecos")
def enderecos():
    return jsonify(
        run_script(
            f"{SERVER}/web/api/enderecos.sh"
        )
    )

@app.route("/api/system")
def system():
    return jsonify(
        run_script(
            f"{SERVER}/web/api/system.sh"
        )
    )


if __name__ == "__main__":
    app.run(
        host="0.0.0.0",
        port=8088
    )
