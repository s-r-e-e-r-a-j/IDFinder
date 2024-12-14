## ID Finder
IDFinder is An OSINT (Open Source Intelligence) tool for finding profiles based on usernames, developed for Termux as well as Linux distributions like Kali Linux, Parrot OS, and others.
It is a tool designed to search  availability of a specific username (or ID) across multiple social media platforms and online services.

## Features
- **Multi-Platform Search**: Checks usernames across multiple platforms with ease.
- **Instant Results:** Quickly provides feedback on whether the username is available or already taken.
- **User-Friendly Output:** Clear, color-coded messages with direct links to profiles on each platform.
- **Results Saved:** All the found results are saved to a file named after the username for later reference.
## Installation
1. **Clone the Repository:**

```bash
git clone https://github.com/s-r-e-e-r-a-j/IDFinder.git
```
2. **Navigate to the IDFinder directory:**
```bash
cd IDFinder
```
3. **Navigate to the IDFinder directory:**
```bash
cd IDFinder
```
4. **Set Up the Script:** The tool is a Bash script, so it can be run directly in any terminal that supports Bash.

5. **Run the Script**
```bash
bash idfinder.sh
```

The script will prompt you with:

```markdown
_____ _____    ______ _           _           
|_   _|  __ \  |  ____(_)         | |          
  | | | |  | | | |__   _ _ __   __| | ___ _ __ 
  | | | |  | | |  __| | | '_ \ / _` |/ _ \ '__|
 _| |_| |__| | | |    | | | | | (_| |  __/ |   
|_____|_____/  |_|    |_|_| |_|\__,_|\___|_| 
                               
                              Developer: Sreeraj         
* copyright of Sreeraj, 2024 *
* GitHub: https://github.com/s-r-e-e-r-a-j *

[>] Input Username:
```
After this prompt, simply enter the username you'd like to search for.

## Usage
Once you run the script, it will display the above prompt. Enter the username you want to check, and the tool will check its availability across various platforms, displaying the results in your terminal.

The results will also be saved to a file named after the username (e.g., sreeraj.txt), which will include the URLs of the platforms where the username is either available or already taken.

Example:

```bash
$ bash idfinder.sh
  
  _____ _____    ______ _           _           
 |_   _|  __ \  |  ____(_)         | |          
   | | | |  | | | |__   _ _ __   __| | ___ _ __ 
   | | | |  | | |  __| | | '_ \ / _` |/ _ \ '__|
  _| |_| |__| | | |    | | | | | (_| |  __/ |   
 |_____|_____/  |_|    |_|_| |_|\__,_|\___|_| 
   
                             Developer:Sreeraj         
                  
[>] Input Username: sree

[>] Checking username sree on social networks: 
[+] Instagram:  Found! https://www.instagram.com/sree
[+] Facebook:  Found! https://www.facebook.com/sree
[+] X (Twitter):  Found! https://x.com/sree
[+] GitLab:  Found! https://gitlab.com/sree
[+] Snapchat:  Found! https://www.snapchat.com/add/sree
[+] Buy Me a Coffee:  Found! https://www.buymeacoffee.com/sree
[+] LinkedIn:  Found! https://www.linkedin.com/in/sree
[+] Saved: sree.txt
```
## File Output
The founded results will be stored as file named you provided username (example: sree.txt).which will include the URLs of the platforms where the username is either available or already taken.

## Customization
- You can modify the list of platforms in the script to add more services or remove existing ones based on your requirements.
- The output format and other options can also be customized by modifying the script.

## License
This tool is open-source and available under the MIT License.

## Author
- **Sreeraj**

- **GitHub**:https://github.com/s-r-e-e-r-a-j

