with import <nixpkgs> { };

# https://www.reddit.com/r/NixOS/comments/1706v6p/vs_code_with_jupyter_on_nixos/
# And then run run-jupyter.sh because it doesn't seem to acknowledge "myenv4"... Whatever.
# TODO: cleanup?

let
  pythonPackages = python314Packages;
in pkgs.mkShell rec {
  name = "impurePythonEnv";
  #venvDir = "./.venv";
  buildInputs = [

    pkgs.stdenv.cc.cc.lib
    # stdenv.cc.cc # jupyter lab needs

    # pythonPackages.python

    python314
    pythonPackages.ipykernel
    pythonPackages.jupyterlab
    pythonPackages.pyzmq    # Adding pyzmq explicitly
    #pythonPackages.venvShellHook
    pythonPackages.pip
    pythonPackages.numpy
    pythonPackages.matplotlib
    pythonPackages.opencv4
    pythonPackages.scikit-image

    # sometimes you might need something additional like the following - you will get some useful error if it is looking for a binary in the environment.
    zlib

  ];

  # Run this command, only after creating the virtual environment
  /*
  postVenvCreation = ''
    unset SOURCE_DATE_EPOCH
    
    #python -m ipykernel install --user --name=myenv4 --display-name="myenv4"
    #pip install -r requirements.txt
  '';
  */

  # Now we can execute any commands within the virtual environment.
  # This is optional and can be left out to run pip manually.
  postShellHook = ''
    # allow pip to install wheels
    unset SOURCE_DATE_EPOCH
  '';
}
