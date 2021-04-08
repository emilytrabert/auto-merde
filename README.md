# :poop: auto-merde
Automated Mermaid.js Entity Relationship DiagramEr

Takes the output of pg_dump and creates a Mermaid.js markdown file.

## Running
1. Call pg_dump on your database and pipe output into a file. This will be the input.
```bash
pg_dump -s > [input_file_name]
```
2. Call the parser with the pg_dump output as the input file.
```bash
ruby parse.rb [input_file_name] [output_file_name]
```
3. Test the output on the [Mermaid.js Live Editor](https://mermaid-js.github.io/mermaid-live-editor/)

You can check in the file in your repo or even display it natively in your wiki on [Gitlab](https://docs.gitlab.com/ee/user/markdown.html#mermaid)
