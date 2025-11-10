{
  fetchFromGitHub,
  python3Packages,
}:
python3Packages.buildPythonApplication {
  pname = "commit";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "1blckhrt";
    repo = "commit";
    rev = "5d469c694676d4767b3d9565d9cb08cf497c34ba";
    hash = "sha256-5bUtdDsmn7vGCGdnOEmU8WkqFpfmsSWYqh0sQPDoEGI=";
  };

  format = "pyproject";

  nativeBuildInputs = with python3Packages; [
    setuptools
  ];

  propagatedBuildInputs = with python3Packages; [
    questionary
    rich
  ];

  doCheck = false;

  meta = {
    description = "Opinionated conventional commit CLI";
    homepage = "https://github.com/1blckhrt/commit";
  };
}
