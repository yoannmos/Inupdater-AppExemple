import json
import os
import webbrowser
from pathlib import Path
from shutil import copyfile, rmtree

from invoke import task


@task()
def clean(c):

    rmtree("build", ignore_errors=True)
    rmtree("dist", ignore_errors=True)
    rmtree(".pytest_cache", ignore_errors=True)
    rmtree("htmlcov", ignore_errors=True)
    rmtree("site", ignore_errors=True)
    rmtree("appexemple/__pycache__", ignore_errors=True)
    rmtree("setup", ignore_errors=True)
    try:
        os.remove(".coverage")
    except:
        pass
    try:
        os.remove("coverage.xml")
    except:
        pass

    for item in os.listdir(Path().cwd()):
        if item.endswith(".spec"):
            os.remove(os.path.join(Path().cwd(), item))

    print("Your repo is clean !")


@task()
def test(c):
    c.run("poetry run coverage run -m pytest")


@task()
def docs(c):
    webbrowser.open("http://127.0.0.1:8000/")
    c.run("poetry run mkdocs serve")


@task(pre=[clean, test])
def build(c):

    app_name = "appexemple"
    dist_path = "C:/Users/*username*/Desktop/appexemple"  # <- PUT YOUR DIST FOLDER HERE or REPLACE *username* FOR QUICK TESTING

    copy_path = Path(dist_path) / Path(".copy")
    try:
        Path(dist_path).mkdir()
        copy_path.mkdir()
    except FileExistsError:
        pass

    for ver in range(1, 4, 1):
        version = f"0.{ver}.0"
        with open(f"{app_name}/__init__.py", "w") as f:
            f.write(f'__version__ = "{version}"')

        c.run(
            f"poetry run pyinstaller --clean --onefile --name {app_name}_{version} --paths .venv/Lib/site-packages --paths .venv/Scripts {app_name}/__main__.py"
        )

        copyfile(
            f"dist/{app_name}_{version}.exe",
            f"{str(copy_path)}/{app_name}_{version}.exe",
        )

    with open(f"{app_name}/__init__.py", "w") as f:
        f.write('__version__ = "0.1.0"')

    copyfile(f"dist/{app_name}_0.1.0.exe", f"dist/{app_name}.exe")
    copyfile(f"dist/{app_name}_0.1.0.exe", f"{str(dist_path)}/{app_name}_0.1.0.exe")
    copyfile("bin/launcher.exe", "dist/launcher.exe")

    settings_dict = {
        "exe_name": "appexemple",
        "dist_path": str(dist_path),
        "version": "0.1.0",
    }
    with open("dist/settings.json", "w") as outfile:
        json.dump(settings_dict, outfile, indent=4)

    c.run("iscc setup.iss")
