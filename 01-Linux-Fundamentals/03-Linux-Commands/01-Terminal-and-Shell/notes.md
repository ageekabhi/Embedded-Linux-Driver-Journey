
# Terminal and Shell – Linux Command-Line Fundamentals

## 1. Introduction

The Linux command line provides an interface through which users interact with the operating system by entering commands.

It is widely used in Linux administration, embedded Linux development, kernel development, debugging, automation, and system-level programming.

Understanding the command line requires understanding three important components:

- Terminal
- Shell
- Linux operating system

## 2. What Is a Terminal?

A terminal is an interface used to enter commands and display their output.

Historically, terminals were physical devices consisting of a keyboard and display connected to a computer.

Modern Linux systems generally use a **terminal emulator**, which is a software application that provides terminal functionality inside a graphical desktop environment.

Examples include:

- GNOME Terminal
- Konsole
- Xfce Terminal
- xterm

The terminal provides the input/output interface. It does not normally interpret Linux commands itself.

## 3. What Is a Shell?

A shell is a command interpreter that accepts commands, interprets them, and coordinates their execution.

It acts as an interface between the user and the operating system.

Common Linux shells include:

| Shell | Description |
|---|---|
| Bash | Bourne Again Shell; widely used on Linux |
| sh | Traditional Unix shell interface |
| Zsh | Extended interactive shell |
| Fish | User-friendly interactive shell |

In this learning journey, Bash is used for command-line experiments.

### 3.1 Terminal vs Shell

| Terminal | Shell |
|---|---|
| Provides the input/output interface | Interprets commands |
| Displays command output | Processes command syntax |
| Sends keyboard input to the shell | Executes builtins and launches programs |
| Example: GNOME Terminal | Example: Bash |

Simplified interaction:

```text
User
  |
  v
Terminal Emulator
  |
  v
Shell (Bash)
  |
  +------> Shell Builtins
  |
  +------> External Programs
  |
  v
Linux Kernel (through system calls when needed)
  |
  v
Hardware and System Resources
```

This is a conceptual view. Not every shell operation requires a system call or launches an external process.

## 4. Understanding the Shell Environment

### 4.1 Identify the configured login shell

Command:

```bash
echo "$SHELL"
```

Example output:

```text
/bin/bash
```

The `SHELL` environment variable commonly identifies the user's configured login shell.

It does not necessarily identify the shell process currently executing a command.

### 4.2 Identify the current shell process

Command:

```bash
ps -p "$$" -o pid,ppid,comm,args
```

Explanation:

- `ps`: Displays process information.
- `-p`: Selects a process by PID.
- `$$`: Bash special parameter containing the PID of the current shell.
- `-o`: Specifies the output columns.
- `pid`: Process ID.
- `ppid`: Parent process ID.
- `comm`: Command name.
- `args`: Command and its arguments.

The PID values depend on the running system and should not be treated as fixed values.

### 4.3 Understanding the shell prompt

A typical Linux prompt may look like:

```text
user@hostname:~/directory$
```

Common components:

- `user`: Current username.
- `hostname`: Computer name.
- `~/directory`: Current working directory.
- `$`: Commonly indicates a regular user shell.

A `#` prompt is commonly used for a root shell.

The prompt is configurable, so its appearance can vary.

## 5. Anatomy of a Linux Command

A command commonly follows this structure:

```text
command [options] [arguments]
```

Example:

```bash
ls -l /home
```

Components:

- `ls`: Command.
- `-l`: Option requesting long-format output.
- `/home`: Argument specifying the target directory.

Options modify command behavior, while arguments provide input or identify the target.

Commands do not all follow identical option rules.

### 5.1 Short and long options

Examples:

```bash
ls -l
ls --all
```

- `-l`: Short option.
- `--all`: Long option.

Some commands support combining short options, but this depends on the command.

## 6. How Does Bash Identify a Command?

A command entered into Bash does not always refer to an external executable.

Common command types include:

1. Alias
2. Shell function
3. Shell builtin
4. External executable

### 6.1 Alias

An alias is a name that Bash expands into another command or command string.

Example:

```bash
alias ll='ls -l'
```

After defining the alias:

```bash
ll
```

Bash expands it to the corresponding command.

An alias is not a separate executable program.

To inspect a command:

```bash
type ls
```

Example output:

```text
ls is aliased to `ls --color=auto'
```

This indicates that `ls` is currently defined as an alias.

### 6.2 Shell Functions

A shell function is a named group of shell commands.

Example:

```bash
hello()
{
    echo "Hello from Bash"
}
```

Execute it using:

```bash
hello
```

Inspect its type using:

```bash
type hello
```

Functions are maintained by the shell environment.

### 6.3 Shell Builtins

A builtin is a command implemented directly inside the shell.

Examples:

- `cd`
- `echo`
- `pwd`
- `read`
- `export`
- `type`

Check a command:

```bash
type cd
```

Example output:

```text
cd is a shell builtin
```

#### Why is `cd` a shell builtin?

The current working directory is a property of a process.

When Bash executes `cd`, it changes the working directory of the current shell process.

If an external child process changed its own working directory, that change would not modify the parent shell's working directory.

This is why `cd` must operate within the current shell environment.

### 6.4 External Executables

External commands are programs stored as executable files.

Examples:

- `/usr/bin/ls`
- `/usr/bin/grep`
- `/usr/bin/cat`

To inspect all known command definitions and locations:

```bash
type -a ls
```

Example output:

```text
ls is aliased to `ls --color=auto'
ls is /usr/bin/ls
ls is /bin/ls
```

To locate the external executable while bypassing aliases and functions:

```bash
type -P ls
```

The exact executable path depends on the system.

## 7. Understanding PATH

`PATH` is an environment variable containing a colon-separated list of directories.

When Bash needs to locate an external command by name, it searches the directories in `PATH`.

Inspect it using:

```bash
echo "$PATH"
```

Conceptual example:

```text
/usr/local/bin:/usr/bin:/bin
```

This represents three directories:

1. `/usr/local/bin`
2. `/usr/bin`
3. `/bin`

The shell searches these directories according to its command-resolution rules.

Do not confuse `PATH` with the path of a specific executable.

### 7.1 Inspect command resolution

Useful commands:

```bash
type ls
type -a ls
type -P ls
command -v ls
```

Their purposes:

| Command | Purpose |
|---|---|
| `type` | Identifies how the shell interprets a command |
| `type -a` | Displays all known definitions and locations |
| `type -P` | Searches for an external executable |
| `command -v` | Displays how the shell resolves a command |

The output of `command -v` can identify an alias, function, builtin, or executable depending on the command.

## 8. What Happens When a Command Is Executed?

Consider:

```bash
ls -l
```

A simplified execution sequence is:

1. The terminal emulator provides the input to the shell.
2. Bash parses the command and its arguments.
3. Bash performs applicable expansions and command resolution.
4. If the command is a builtin or function, Bash executes it within the shell.
5. If it is an external executable, Bash arranges for the program to execute.
6. The program performs its required operations.
7. The program may request kernel services through system calls.
8. Output is written to the appropriate output stream.
9. The terminal emulator displays the output.

External program execution commonly involves process creation and an `exec` operation, although shells can use optimizations in some situations.

Not every command creates a new process. For example, `cd` runs as a Bash builtin.

## 9. Practical Commands Learned

| Command | Purpose |
|---|---|
| `echo "$SHELL"` | Displays the configured shell path |
| `ps` | Displays process information |
| `type` | Identifies command type |
| `type -a` | Shows all known command definitions |
| `type -P` | Locates an external executable |
| `command -v` | Shows command resolution |
| `echo "$PATH"` | Displays executable search directories |
| `alias` | Displays or defines aliases |
| `pwd` | Displays the current working directory |

## 10. Relevance to Embedded Linux Development

Command-line knowledge is essential for embedded Linux engineering.

It is used to:

- Navigate embedded Linux source trees.
- Build and configure Linux kernels.
- Compile applications and cross-compiled binaries.
- Inspect processes and system resources.
- Load and debug kernel modules.
- Inspect device information under `/proc` and `/sys`.
- Automate build and deployment operations using shell scripts.
- Debug target systems through serial consoles and SSH.

## 11. Unit Summary

In this unit, the following concepts were studied:

- Difference between terminal and shell.
- Role of Bash as a command interpreter.
- Shell environment and process identification.
- Command structure, options, and arguments.
- Aliases, functions, builtins, and external executables.
- Command resolution using `type` and related commands.
- Purpose of the `PATH` environment variable.
- Simplified command execution flow.

**Next unit:** File and Directory Management in Linux.
