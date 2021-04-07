# Basic parser
# Syntax: ruby parse.rb [input_file_name] [output_file_name]
# Example: ruby parse.rb test/college/college_dump.sql test/college/college_output.md

private def line_useful?(line)
  line.start_with?('CREATE')
end

def main(input_file_name, output_file_name)
  tables = []

  table = ''
  continue_grabbing_table = false
  File.foreach(input_file_name) do |line|
    if continue_grabbing_table
      table += line
      if line.scan(')').count > line.scan('(').count
        continue_grabbing_table = false
        tables.append(table)
        table = ''
        next
      end
    end

    is_useful = line_useful? line
    next unless is_useful
    table += line
    continue_grabbing_table = true
  end

  output_file = File.open(output_file_name, 'w')
  output_file.write("erDiagram\n")
  tables.each do |t|
    pieces = t.split(' ')
    raw_table_name = pieces[2]
    table_name = raw_table_name.include?('.') ? raw_table_name.split('.')[1] : raw_table_name
    output_file.write("\t#{table_name} {}\n")
  end
  output_file.close
end

main(ARGV[0], ARGV[1])
