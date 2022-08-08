# Scaffi
The only scaffolding tool you will ever need!

## How to install:

npm i -g scaffi

## How to use:

1. Create your custom template like this one: https://github.com/wolfiesites/scaffi-example-template
2. Store it either locally or in repo
3. use the command below to download template and search replace placeholders:

```scaffi --placeholder="value of the placeholder" --placetwo="second value" --template="/path/to/repo"```


### Example:
`scaffi --directory="my awesome dir" --dirtwo="my amazing dir two" --filename="Scaffi is the best" --name="custom variable" -t="https://github.com/wolfiesites/scaffi-example-template"`


## For further explanation use:

```scaffi --help```




<span style="color:red;">Package is new please consider making copy of your template before using template</span>


<b>IMPORTANT:</b><br>
IT WORKS ON UNIX BASED (MAC / LINUX) SYSTEMS WITH BASH INSTALLED<br>
IF YOU'RE on WINDOWS, Please consider using WSL</b>

## Future features:
* conditional placeholders with block of code
* interactive mode
* feed placeholders with file config
* getting private repos with token auth

<hr/>
## Smart usecases:
### Please consider using .bashrc / .bashprofile to bend it to your will:
in `~/.basrhrc` add:
```
newblock() {
	scaffi --same-value="$*" -t=""
}
```
and use a command in terminal: `newblock my amazing new block`<br>
your imagination is a key! ;>