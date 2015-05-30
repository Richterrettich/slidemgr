# slidemgr
A little commandline program to generate and manage reveal.js slides. Checkout 
(https://github.com/hakimel/reveal.js/)[reveal.js].It's pretty cool.

## Installation
You need Ruby installed in order to use slidemgr. I tested it with 2.2, but I
guess it is compatible with older releases as well.
Take a look at https://www.ruby-lang.org/en/documentation/installation/
to install ruby.
After that, fire up a terminal and type in:
```bash
gem install slidemgr
```
You can now use slidemgr.
## Usage
slidemgr is a commandline program. Open a terminal and type in `slidemgr`
to get a list of options.

### Initialize a new project

The first thing you want to do is initializing a new project. A project can contain
multiple cohesive presentations. I'll do an example for a lecture called *programming*.
The command for initializing a project is `init`:

```bash
slidemgr init
```

slidemgr will ask you a view questions about your project. In order to synchronize
your master-presentation with the audience, you need a token/secret pair. Thus 
slidemgr will ask you for Socket.io-host. reveal.js offers a public server at
http://revealjs.jit.su/ , so you can use this one if you like.

You can skip the interactive process by passing the required information to slidemgr:
```bash
slidemgr init programming --host revealjs.jit.su --git git@github.com/path/to/repo
```
After the initialization you can see that slidemgr creates a new directory 
containing your project. Now change into the project-directory. 
```bash
cd programming
```
All following commands need you to be within the project-directory-structure.
Let's take a look what happened.
```bash
ls
# output
client  config.yml  master
```
Both master and clientfolder contain a minimal installation of reveal.js. The
idea is simple. You present the master-slides to your audience. The audience 
should get served client-slides to their own devices.
The key strength of slidemgr is the synchrinization between master-slides and
client-slides, so you can easily make changes without the hassle of doing a
manual sync. The file `config.yml` is intended for project-wide meta information.
You can change your initial settings here if you want.

**Beware**

Do not rename or remove the config.yml file. You shouldn't move around files that are outside
the content-folder either.

### Create a new presentation
To create a new presentation use the command `create`:
```bash
slidemgr create hello_world 
```
this will create both a new master-presentation, as well as a client-presentation.

To alter the content of your newly generated presentation, change the file within
`master/slides/YOUR_PRESENTATION_NAME/content/content.md`

The content is written in [markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet). 
To seperate slides, use the following:

| --  | vertical slide   |
|-----|------------------|
| --- | horizontal slide |

```markdown
## Hello World

--

Tradition demands, that the first program should print "Hello World!"

---

## Java

--

![an image](content/image.png)
```

If you want to place an image, it's easiest to store them within the content-directory.
After that reference the image like in the example above.


### Synchronize your work

After adding some content to your new presentation, you need to sync it with the client.
Use the `sync` command:

```bash
slidemgr sync
```

this syncs all your presentations. If you only want to sync a particular presentation,
give the name of the presentation as an argument:

```bash
slidemgr sync hello_world
```
The synchronization will copy all content from the master-slides to client-slides.
If you have a git-repository, it will also commit your changes and push them to the remote-repository (if present).

### Start your presentation
Slidemgr has a built-in webserver to start your presentation. Use the `start` command.
```bash
slidemgr start
```
It will start the webserver and open your default-browser. If you specify a presentation as
a parameter, it will automatically navigate to the presentation.
To stop the server, switch back to your terminal where you started the server and press CTRL+C.

### Other commands

Slidemgr comes with a view more commands. Use the builtin help to see their usage.

## Copyright
### slidemgr
Copyright (c) 2015 Rene Richter
slidemgr is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software Foundation,
Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA


### reveal.js
MIT licensed

Copyright (C) 2015 Hakim El Hattab, http://hakim.se



