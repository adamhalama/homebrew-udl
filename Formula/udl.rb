class Udl < Formula
  desc "Set up and sync local music libraries from SoundCloud and Spotify sources"
  homepage "https://github.com/adamhalama/music-library-sync"
  version "0.1.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/adamhalama/music-library-sync/releases/download/v#{version}/udl-v#{version}-darwin-arm64.tar.gz"
      sha256 "083d2e76179d3788fb9bf129fcf98d5096fb508535f0582610f862bcb3e8e3f1"
    else
      url "https://github.com/adamhalama/music-library-sync/releases/download/v#{version}/udl-v#{version}-darwin-amd64.tar.gz"
      sha256 "024e78dc55c1a025c4cf86b6f6cdf612f80f4fd3ad7effa3691d9cda2aa1462a"
    end
  end

  def install
    libexec.install Dir["*"]
    chmod "+x", libexec/"udl"
    chmod "+x", libexec/"tools/scdl"
    chmod "+x", libexec/"tools/yt-dlp"
    (bin/"udl").write_env_script libexec/"udl", PATH: "#{libexec}/tools:$PATH"
  end

  test do
    assert_match "udl version", shell_output("#{bin}/udl version")
    output = shell_output("#{bin}/udl doctor")
    assert_match "no sources configured yet", output
  end
end
