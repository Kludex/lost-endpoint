import re

from fastapi import FastAPI

app = FastAPI()


@app.get("/{name}")
def a(name: str):
    return {"name": name}


@app.get("/b/{name}")
def b(name: str):
    return {"name": name}


@app.get("/b")
def another_b():
    return {"name": "another_b"}


@app.get("/b/")
def another_b_slash():
    return {"name": "another_b_slash"}


@app.get("/b/b")
def another_b_b():
    return {"name": "another_b_b"}


@app.get("/b/b/")
def another_b_b_slash():
    return {"name": "another_b_b_slash"}


def validate_routes(app):
    routes = []
    duplicated = []
    for route in app.routes:
        path = route.path
        path = re.sub(r"\{.*\}", "\\\w", path)
        routes.append(path)

    for i in range(len(routes)):
        for j in range(i + 1, len(routes)):
            if i == j:
                continue

            first = routes[i]
            second = routes[j]

            first_chunks = len(list(filter(lambda x: x != "", first.split("/"))))
            second_chunks = len(list(filter(lambda x: x != "", second.split("/"))))

            if first.count("/") == second.count("/") and first_chunks == second_chunks:
                if re.match(first, second):
                    duplicated.append(f"{second} is contained by {first}")

    if duplicated:
        raise Exception("\n".join(duplicated)) from None


validate_routes(app)
