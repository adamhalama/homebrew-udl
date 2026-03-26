class Udl < Formula
  desc "Set up and sync local music libraries from SoundCloud and Spotify sources"
  homepage "https://github.com/adamhalama/music-library-sync"
  version "0.1.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/adamhalama/music-library-sync/releases/download/v#{version}/udl-v#{version}-darwin-arm64.tar.gz"
      sha256 "937db093424a72598ecf784117c2d0a35aea12ac9367b60cff921da170f3b728"
    else
      url "https://github.com/adamhalama/music-library-sync/releases/download/v#{version}/udl-v#{version}-darwin-amd64.tar.gz"
      sha256 "6caa15c915f8b49672990e8c9a52c57ad19dbb604d585971c354d66cd9044bfa"
    end
  end

  def install
    libexec.install Dir["*"]
    chmod "+x", libexec/"udl"
    chmod "+x", libexec/"tools/scdl"
    chmod "+x", libexec/"tools/yt-dlp"
    bin.write_env_script libexec/"udl", PATH: "#{libexec}/tools:$PATH"
  end

  test do
    assert_match "udl version", shell_output("#{bin}/udl version")
    output = shell_output("#{bin}/udl doctor")
    assert_match "no sources configured yet", output
  end
end
