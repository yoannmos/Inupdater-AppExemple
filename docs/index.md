# Inupdater-AppExemple

------------------------------------------------------------------------

[![License](https://img.shields.io/github/license/mashape/apistatus.svg)](https://pypi.org/project/isort/)
[![test](https://github.com/yoannmos/Inupdater-AppExemple/actions/workflows/main.yml/badge.svg)](https://github.com/yoannmos/Inupdater-AppExemple)
[![codecov](https://codecov.io/gh/yoannmos/Inupdater-AppExemple/branch/master/graph/badge.svg?token=CV7RJU2RWM)](https://codecov.io/gh/yoannmos/Inupdater-AppExemple)

------------------------------------------------------------------------

[Read Latest Documentation](https://yoannmos.github.io/Inupdater-AppExemple/) - [Browse GitHub Code Repository](https://github.com/yoannmos/Inupdater-AppExemple/)

------------------------------------------------------------------------

## Descriprion

This is app exemple to demonstrate the implementation of [Inupdater](https://github.com/yoannmos/inupdater/)

## How to build the exemple

To test the implementation you need Git, Poetry and Innosetup with iscc into your path.
For more details to install those tools check [Python Guide](https://yoannmos.github.io/PythonGuide/).

### Clone and Requierment

You will first need to clone the repository using `git` and place yourself in its directory:

```cmd
...\ > git clone https://github.com/yoannmos/Inupdater-AppExemple.git _InupdaterAppExemple
...\ > cd _InupdaterAppExemple
```

Now, you will need to install the required dependency and be sure that the current tests are passing on your machine :

```cmd
...\_InupdaterAppexemple > poetry install
...\_InupdaterAppexemple > poetry run inv test
```

### Choose the dist folder and build

Now you can modify the `task.py` to change your dist location.

The folder will be created if it doesn't exist. For simplicity you can change only *username* to your username.

```python
@task(pre=[clean, test])
def build(c):

    app_name = "appexemple"
    dist_path = "C:/Users/*username*/Desktop/appexemple"  # <- PUT YOUR DIST FOLDER HERE

```

Then you can simply execute the build command.

```cmd
...\_InupdaterAppexemple > poetry run inv build
```

### Install the setup and launch the app

You have created an installer in `setup/`, run it to install the app.

When the app is installed you can `Right-Click` in a folder background and execute `Appexemple`.

It will first run the launcher to find update then execute the last update of appexemple.

You can copy a new version (i.e : appexemple_0.2.0.exe) from `*yourdist*/.copy` to `yourdist/`.

When you reexecute `Appexemple` you will see the new version of the app.

### Conclusion

In real application simply push your new released .exe in a shared dist location to update your software users.
