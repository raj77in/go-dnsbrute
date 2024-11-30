package main

import (
    "bufio"
    "fmt"
    "net"
    "os"
    "sync"
)

func resolveSubdomain(subdomain string, domain string, results chan string, wg *sync.WaitGroup) {
    defer wg.Done()
    fullDomain := subdomain + "." + domain
    _, err := net.LookupHost(fullDomain)
    if err == nil {
        fmt.Println(fullDomain)
        results <- fullDomain
    }
}

func worker(domain string, wordlist chan string, results chan string, wg *sync.WaitGroup) {
    for subdomain := range wordlist {
        wg.Add(1)
        resolveSubdomain(subdomain, domain, results, wg)
    }
}

func loadWordlist(wordlistPath string) ([]string, error) {
    file, err := os.Open(wordlistPath)
    if err != nil {
        return nil, err
    }
    defer file.Close()

    var wordlist []string
    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
        wordlist = append(wordlist, scanner.Text())
    }
    if err := scanner.Err(); err != nil {
        return nil, err
    }
    return wordlist, nil
}

func main() {
    if len(os.Args) != 4 {
        fmt.Println("Usage: go run main.go <domain> <wordlist> <threads>")
        os.Exit(1)
    }

    domain := os.Args[1]
    wordlistPath := os.Args[2]
    threadCount := 0

    // Parse thread count
    _, err := fmt.Sscanf(os.Args[3], "%d", &threadCount)
    if err != nil || threadCount <= 0 {
        fmt.Println("Invalid number of threads. Provide a positive integer.")
        os.Exit(1)
    }

    // Load the wordlist
    wordlist, err := loadWordlist(wordlistPath)
    if err != nil {
        fmt.Println("Error loading wordlist:", err)
        os.Exit(1)
    }

    // Channels for wordlist distribution and result collection
    wordlistChan := make(chan string, len(wordlist))
    resultsChan := make(chan string)
    var wg sync.WaitGroup

    // Start workers
    for i := 0; i < threadCount; i++ {
        go worker(domain, wordlistChan, resultsChan, &wg)
    }

    // Feed wordlist into the channel
    for _, word := range wordlist {
        wordlistChan <- word
    }
    close(wordlistChan)

    // Wait for all goroutines to finish
    go func() {
        wg.Wait()
        close(resultsChan)
    }()

    // Collect results
    found := make([]string, 0)
    for result := range resultsChan {
        found = append(found, result)
    }

}

