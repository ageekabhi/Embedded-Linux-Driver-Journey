
# Day 03 – Practical: Terminal and Shell

## 1. Objective

Understand how the Linux terminal and Bash shell interact, identify the current shell process, and investigate how Bash resolves commands.

## 2. Environment

- Operating System: Zorin OS 18.1
- Shell: Bash
- Architecture: x86_64

## 3. Experiments Performed

### Experiment 1: Identify the configured shell

Command:

```bash
echo "$SHELL"
```

Observed output:

```text
/bin/bash
```

Explanation:

The `SHELL` environment variable identifies the user's configured login shell.

In this environment, Bash is configured as the login shell.

### Experiment 2: Identify the current shell process

Command:

```bash
ps -p "$$" -o pid,ppid,comm,args
```

Observed result:

The command displayed the current Bash process, its parent process ID, command name, and command-line arguments.

Explanation:

- `ps` displays process information.
- `$$` expands to the current Bash process ID.
- `-p` selects a process.
- `-o` specifies the output columns.

Process IDs are dynamic and are intentionally not recorded as fixed values.

### Experiment 3: Identify the type of `ls`

Command:

```bash
type ls
```

Observed output:

```text
ls is aliased to `ls --color=auto'
```

Explanation:

The shell identifies `ls` as an alias.

Bash expands the alias to include the `--color=auto` option when the alias is applicable.

### Experiment 4: Inspect the PATH variable

Command:

```bash
echo "$PATH"
```

Observed result:

The command displayed a colon-separated list of directories.

Explanation:

`PATH` contains directories in which the shell searches for external executables.

The actual output is not reproduced because it contains machine-specific directories and toolchain paths.

### Experiment 5: Identify `cd`

Command:

```bash
type cd
```

Observed output:

```text
cd is a shell builtin
```

Explanation:

`cd` is implemented inside Bash.

It changes the current working directory of the shell process itself.

### Experiment 6: Display all known definitions of `cd`

Command:

```bash
type -a cd
```

Observed output:

```text
cd is a shell builtin
```

Explanation:

The command displays the available definitions and locations known to Bash.

Only the shell builtin was reported for `cd`.

### Experiment 7: Display all known definitions of `ls`

Command:

```bash
type -a ls
```

Observed output:

```text
ls is aliased to `ls --color=auto'
ls is /usr/bin/ls
ls is /bin/ls
```

Explanation:

Bash identified:

1. An alias named `ls`.
2. An executable at `/usr/bin/ls`.
3. An executable path at `/bin/ls`.

On merged-/usr Linux distributions, `/bin` may be a symbolic link to `/usr/bin`. Therefore, these paths do not necessarily represent two different executable files.

### Experiment 8: Inspect command resolution

Command:

```bash
command -v ls
```

Observed output:

```text
alias ls='ls --color=auto'
```

Explanation:

`command -v` reports how the shell resolves a command.

Since `ls` is an alias in this Bash environment, the alias definition was displayed instead of an executable path.

## 4. Key Observations

1. The terminal emulator provides the interface for interacting with Bash.
2. Bash interprets commands and manages shell execution.
3. `$SHELL` and `$$` provide different information.
4. Commands can be aliases, functions, builtins, or external executables.
5. `cd` is a builtin because it must change the current shell's working directory.
6. `PATH` is used to locate external executables.
7. `type`, `type -a`, and `command -v` help investigate command resolution.

## 5. Practical Learning Outcome

The experiments established how Bash identifies commands and how the shell environment can be inspected.

These concepts provide the foundation for shell scripting, Linux system administration, kernel development, and embedded Linux debugging.

## 6. Further Experiments

The following experiments are planned but have not yet been performed:

- Inspect `/bin` and `/usr/bin` using `ls -ld`.
- Locate the external `ls` executable using `type -P ls`.
- Create and inspect a temporary shell function.
- Define and test a custom alias.
