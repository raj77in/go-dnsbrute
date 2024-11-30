# go-dnsbrute

**go-dnsbrute** is a fast and lightweight DNS brute-forcing tool written in Go. It helps identify valid subdomains under a given domain by leveraging a wordlist and multi-threading. This utility is designed for security researchers and penetration testers who need to map out subdomains efficiently. With no extra frills, it is very easy to use in any automation script.

## Features

* **Multi-threaded Execution**: Use a configurable number of threads to maximize performance.
* **Wordlist Support**: Specify your own wordlist for flexible brute-forcing.
* **Recursive Discovery**: Automatically finds subdomains of discovered subdomains.
* **Lightweight**: Built with Go for speed and simplicity.

---

## Installation

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/yourusername/go-dnsbrute.git
   cd go-dnsbrute
   ```

2. **Build the Binary**:

   ```bash
   go build -o go-dnsbrute
   ```

3. **Verify Installation**:
   Run the tool to see the usage instructions:

   ```bash
   ./go-dnsbrute -h
   ```

4. Optionally, copy the binary to `/usr/local/bin`.

   ```bash
   cp ./go-dnsbrute /usr/local/bin
   ```

## Usage

```bash
./go-dnsbrute <domain> <wordlist> <threads>
```

### Example:

```bash
./go-dnsbrute example[.]com subdomains.txt 10
```

* **Parameters**:
  * `<domain>`: The target domain for brute-forcing.
  * `<wordlist>`: Path to the file containing potential subdomain names (one per line).
  * `<threads>`: Number of threads to use for concurrent requests.

### Output:

The tool will display discovered subdomains in real-time.


## Wordlist Example

The wordlist should be a plain text file with one potential subdomain per line:

```plaintext
www
mail
ftp
admin
test
```

## Contributing

Contributions are welcome! If you find a bug or have an idea for a feature, feel free to open an issue or submit a pull request.


## Disclaimer

This tool is intended for educational and authorized security testing purposes only. Unauthorized use of this tool is prohibited and may violate local, state, or federal laws.

## Note

 I like using the following dictionaries:'

* [httparchive_subdomains_2024_05_28](https://wordlists-cdn.assetnote.io/data/automated/httparchive_subdomains_2024_05_28.txt)
* [2m-subdomains](https://wordlists-cdn.assetnote.io/data/manual/2m-subdomains.txt)
* [best-dns-wordlist](https://wordlists-cdn.assetnote.io/data/manual/best-dns-wordlist.txt)
* [sorted_knock_dnsrecon_fierce_recon-ng](https://github.com/danielmiessler/SecLists/blob/master/Discovery/DNS/sorted_knock_dnsrecon_fierce_recon-ng.txt)

## Pro Tip

You can download all these wordlists and then `cat` them all to single file and run it through `sort|uniq` to use as
wordlist.

