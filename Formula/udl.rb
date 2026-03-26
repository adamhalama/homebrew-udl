class Udl < Formula
  desc "Set up and sync local music libraries from SoundCloud and Spotify sources"
  homepage "https://github.com/adamhalama/music-library-sync"
  version "0.1.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/adamhalama/music-library-sync/releases/download/v#{version}/udl-v#{version}-darwin-arm64.tar.gz"
      sha256 "1c6fc766fdbe6f084a97d61ea8e884e3031a07b1aba2b0ad6db0e7ed8819a1e0"
    else
      url "https://github.com/adamhalama/music-library-sync/releases/download/v#{version}/udl-v#{version}-darwin-amd64.tar.gz"
      sha256 "aed90a84d5523f6566760b6d79156ee8e701b0883ab63111a90b81c773fe303c"
    end
  end

  def install
    libexec.install Dir["*"]
    chmod "+x", libexec/"udl"
    chmod "+x", libexec/"tools/scdl"
    chmod "+x", libexec/"tools/yt-dlp"
    bin.write_env_script libexec/"udl", PATH: "\#{libexec}/tools:$PATH"
  end

  test do
    assert_match "udl version", shell_output("\#{bin}/udl version")
    output = shell_output("\#{bin}/udl doctor")
    assert_match "no sources configured yet", output
  end
end
