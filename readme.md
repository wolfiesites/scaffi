# Scaffi
The only scaffolding tool you will ever need!

## How to install:

npm i -g scaffi

## How to use:

1. Create your custom template like this one: https://github.com/wolfiesites/scaffi-example-template
2. Store it either locally or in repo
3. use the command below to download template and search replace placeholders:

```scaffi --placeholder="value of the placeholder" --placetwo="second value" --template="/path/to/repo"```


## Example:
`scaffi --directory="my awesome dir" --dirtwo="my amazing dir two" --filename="Scaffi is the best" --name="custom variable" -t="https://github.com/wolfiesites/scaffi-example-template"`


## For further explanation use:

```scaffi --help```

## How it works:
1. Scaffi takes placeholders from template: 
* #{{name}}
* #{{nameKC}}
* #{{nameSC}}
* #{{nameCC}}
* #{{namePC}}
* #{{nameSPACE}}
* #{{yourimaginaryplaceholder}}
* #{{yourimaginaryplaceholderKC}}
* #{{yourimaginaryplaceholderSC}}
* #{{yourimaginaryplaceholderCC}}
* #{{yourimaginaryplaceholderPC}}
* #{{yourimaginaryplaceholderSPACE}}

2. defined values for those placholders in flags:<br> --name="awesome scaffi" --yourimaginaryplaceholder="imgainary is good"
3. takes and converts it to all the cases:

| suffix|explanation|replacement|
|--|--|--|
|KC| KEBAB CASE | 							awesome-scaffi |
|SC| SNAKE CASE | 							awesome_scaffi |
|CC| CAMEL CASE | 							awesomeScaffi  |
|PC| PASCAL CASE  | 							AwesomeScaffi |
|SPACE| NORMAL STRING WITH SPACES |			awesome scaffi |

4. placeholders can be used as:
* directory
* filename
* variables in files



<span style="color:red;">Package is new please consider making copy of your template before using template</span>


<b>IMPORTANT:</b><br>
IT WORKS ON UNIX BASED (MAC / LINUX) SYSTEMS WITH BASH INSTALLED<br>
IF YOU'RE on WINDOWS, Please consider using WSL</b>

## Future features:
* conditional placeholders with block of code
* interactive mode
* feed placeholders with config file.json
* getting private repos with token auth

<hr/>

## Smart usecases:
### Please consider using .bashrc / .bashprofile to bend it to your will:
in `~/.basrhrc` add:
```
newblock() {
	scaffi --same-value="$*" -t="/your/amazing/template"
}
```
and use a command in terminal: `newblock my amazing new block`<br>
your imagination is a key! ;>