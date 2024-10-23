# metamorph-docs

Docs for MetaMorph

## BUILD
`docker build -t aneeshep/metamorph-docs .`


#### RUN

`docker run  -v ${PWD}:/opt/metamorph -it -p 8089:8000 aneeshep/metamorph-docs`



#### USAGE

open your brower and point to `http://localhost:8089` to see the docs


#### EDITING


Open your favourite editor and change the md files inside docs directory, make the changes
and save the file. Browser will automatically reload with the changes
