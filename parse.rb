# Basic parser
# Syntax: ruby parse.rb [input_file_name] [output_file_name]
# Example: ruby parse.rb test/college/college_dump.sql test/college/college_output.md



private def creates_table?(line)
  line.start_with?('CREATE')
end

private def alters_table?(line)
  line.start_with?('ALTER TABLE')
end

def main(input_file_name, output_file_name)
  tables = []
  alters = []

  table = ''
  alter = ''
  continue_grabbing_table = false
  continue_grabbing_alter = false
  File.foreach(input_file_name) do |line|
    if continue_grabbing_table
      table += line
      if line.scan(')').count > line.scan('(').count
        continue_grabbing_table = false
        tables.append(table)
        table = ''
        next
      end
    elsif continue_grabbing_alter
      alter += line
      continue_grabbing_alter = false
      alters.append(alter)
      alter = ''
      next
    end

    if creates_table?(line)
      table += line
      continue_grabbing_table = true
    elsif alters_table?(line)
      alter += line
      continue_grabbing_alter = true
    end
  end

  output_file = File.open(output_file_name, 'w')
  output_file.write("erDiagram\n")
  tables.each do |t|
    pieces = t.split(' ')
    raw_table_name = pieces[2]
    table_name = raw_table_name.include?('.') ? raw_table_name.split('.')[1] : raw_table_name
    output_file.write("\t#{table_name} {}\n")
  end
  alters.each do |a|
    if a.include?('FOREIGN KEY')
      table_name = a.split(' ')[3].split('.')[1]
      fk_table_name = a.split('REFERENCES')[1].split('.')[1].split('(')[0]
      output_file.write("\t#{table_name} }|--|| #{fk_table_name} : \"\"\n")
    end
  end
  output_file.close
end

main(ARGV[0], ARGV[1])
