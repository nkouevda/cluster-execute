<!-- Nikita Kouevda -->
<!-- 2014/10/05 -->

# cluster-execute

Execute scripts on a cluster of servers connected to the same file system.

This framework is a generalization of the implementation used in
[ucb-eecs-servers](https://github.com/nkouevda/ucb-eecs-servers).

## Setup

1. Clone this repository:

        git clone https://github.com/nkouevda/cluster-execute.git
        cd cluster-execute

2. Place the list of servers in [`data/servers.txt`](data/servers.txt), one per
   line. Empty lines and lines starting with `#` will be ignored.

3. In [`bin/settings.sh`](bin/settings.sh), specify the main remote server and
   the username with which to connect to servers.

4. Edit [`bin/task.sh`](bin/task.sh), the script to be executed on each server.

5. Run [`bin/setup.sh`](bin/setup.sh) to copy all local files to the remote file
   system.

## Usage

All output will be stored in `output/$$/` on the server on which
[`bin/main.sh`](bin/main.sh) is executed. The full path of this directory is
printed by [`bin/main.sh`](bin/main.sh) each time.

If the output is desired locally, run [`bin/main.sh`](bin/main.sh) directly.
Otherwise, run [`bin/remote.sh`](bin/remote.sh).

The standard output and error for each server will be stored in
`output/$$/std{out,err}/`; the concatenated data will be in
`output/$$/std{out,err}.txt`. Note that this data will be concatenated from the
individual files in whatever order `cat *` produces, regardless of the order in
which servers are listed in [`data/servers.txt`](data/servers.txt).

`output/$$/offline.txt` will contain a list of the servers for which `ssh`
returned a non-0 exit status.

## License

Licensed under the [MIT License](http://www.opensource.org/licenses/MIT).
