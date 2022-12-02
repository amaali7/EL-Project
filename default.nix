let
  pkgs = import <nixpkgs> { };
  src_r = pkgs.fetchFromGitHub rec {
    owner = "amaali7";
    repo = "EL-Project";
    rev = "82df738987a5b0d7eb83b7241211cf148a8cb5c9";
    sha256 = "1xxipf56yj4gl4mfaaivcbz87a7p2dnispig9gby2w3zhc47bdmx";
  };
in pkgs.python310Packages.buildPythonApplication rec {
  pname = "evillimiter";
  version = "1.5.0";
  src = src_r;

  buildInputs = with pkgs;[
    iptables
  ];
  propagatedBuildInputs = with pkgs; [
    python310Packages.colorama
     python310Packages.matplotlib
    iproute2
    iptables
    python310Packages.netaddr
    python310Packages.netifaces
    python310Packages.scapy
    python310Packages.terminaltables
    python310Packages.tqdm
    python310Packages.setuptools
  ];

  # no tests present
  doCheck = false;

  pythonImportsCheck = [ "evillimiter.evillimiter" ];

  meta = with pkgs.lib; {
    description = "Tool that monitors, analyzes and limits the bandwidth";
    longDescription = ''
      A tool to monitor, analyze and limit the bandwidth (upload/download) of
      devices on your local network without physical or administrative access.
      evillimiter employs ARP spoofing and traffic shaping to throttle the
      bandwidth of hosts on the network.
    '';
    homepage = "https://github.com/bitbrute/evillimiter";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
  };
}
