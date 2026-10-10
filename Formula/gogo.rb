class Gogo < Formula
  desc "Open a configured terminal workspace with one command"
  homepage "https://github.com/conorbr/gogo"
  url "https://github.com/conorbr/gogo/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "1caa1f48e0332f24a8cacaf30b0136af16164cdac0bf6d83cda2fcddd042e47a"
  license any_of: ["MIT", "Apache-2.0"]
  head "https://github.com/conorbr/gogo.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "gogo #{version}", shell_output("#{bin}/gogo version")

    (testpath/".config/gogo/spaces/demo.toml").write <<~TOML
      dir = "#{testpath}"

      [[tab]]
      name = "Shell"
      run = "echo hi"
    TOML
    ENV["XDG_CONFIG_HOME"] = testpath/".config"
    assert_match "run in Shell: echo hi", shell_output("#{bin}/gogo herdr demo --dry-run")
  end
end
