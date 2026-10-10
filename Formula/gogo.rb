class Gogo < Formula
  desc "Open a configured terminal workspace with one command"
  homepage "https://github.com/conorbr/gogo"
  license any_of: ["MIT", "Apache-2.0"]

  # Prebuilt binaries from the GitHub Release. Nothing to compile.
  on_macos do
    on_arm do
      url "https://github.com/conorbr/gogo/releases/download/v0.1.1/gogo-v0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "2326ab7191e14e8d3558afd4952c56c87adf0b24ebcfb34baf09d1b8a7eef792"
    end
    on_intel do
      url "https://github.com/conorbr/gogo/releases/download/v0.1.1/gogo-v0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "0240cf6e2cde6149e4ad90d54fbe3c0ba61a07750916893aaa4d97c15a37cdb5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/conorbr/gogo/releases/download/v0.1.1/gogo-v0.1.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8021b32fe1aaf24324cd49a6e3c95535aa9c172c41029c1b7d968cd794b9fa6e"
    end
    on_intel do
      url "https://github.com/conorbr/gogo/releases/download/v0.1.1/gogo-v0.1.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c38dfd1849f162caa47296dd31acf977945e580fb0683ea23d62cd4252e6fda7"
    end
  end

  def install
    bin.install "gogo"
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
