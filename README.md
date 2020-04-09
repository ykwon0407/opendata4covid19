# Open Data 4 Covid 19

# With thanks to:
# The Republic of Korea
# The Ministry of Health and Welfare and
# Health Insurance Review & Assessment Service
# Website: https://hira-covid19.net/

Korean COVID-19 data extraction

If you don't have R you are going to need it.

You can download R here:

https://cran.csiro.au/

And you can download RStudio here:

https://rstudio.com/products/rstudio/

Just the free Desktop version is fine.

[Linux/Unix]

R uses CRAN for package management so put this in ~./.Rprofile

## Default repo
local({r <- getOption("repos")
       r["CRAN"] <- "http://cran.r-project.org" 
       options(repos=r)
})

You run an R script from the command line like this

Rscript <script>

Or you can do this

$ which Rscript
/usr/local/bin/Rscript

Then put 

#!/usr/local/bin/Rscript in the shebang line and make the file executable with 

chmod 755 <script>

RStudio may look after the details for you but for that you will need to RTFM at https://rstudio.com/products/rstudio/

[Windows]

If you use Windows, I'm sorry but I can't help. 

I don't but feel free to add instructions here!
