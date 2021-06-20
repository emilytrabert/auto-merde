# Basic parser
# Syntax: ruby parse.rb [input_file_name] [output_file_name]
# Example: ruby parse.rb test/college/college_dump.sql test/college/college_output.md

private def useless?(line)
  /(START WITH|INCREMENT BY|NO MINVALUE|NO MAXVALUE)/.match?(line)
end

private def creates_table?(line)
  line.start_with?('CREATE TABLE')
end

private def alters_table?(line)
  line.start_with?('ALTER TABLE')
end

private def get_table_name_from_create(line)
  pieces = line.split(' ')
  raw_table_name = pieces[2]
  table_name = raw_table_name.include?('.') ? raw_table_name.split('.')[1] : raw_table_name
  table_name
end

private def get_table_name_from_alter(line)
  pieces = line.split(' ')
  raw_table_name = pieces[3]
  table_name = raw_table_name.include?('.') ? raw_table_name.split('.')[1] : raw_table_name
  table_name
end

private def get_fk_table_name_from_alter(line)
  pieces = line.split('REFERENCES')
  raw_table_name = pieces[1]
  table_name = raw_table_name.include?('.') ? raw_table_name.split('.')[1] : raw_table_name
  table_name.split('(')[0]
end

private def get_column_data(attrs)
  pairs = []
  attrs.each do |a|
    pieces = a.strip.split(' ')
    data_type = map_data_type(pieces[1..-1].join('_'))
    pairs.append([data_type, pieces[0]])
  end
  pairs
end

private def map_data_type(raw_data_type)
  if /(integer|bigint)/i.match?(raw_data_type)
    'int'
  elsif /(character_varying|text)/i.match?(raw_data_type)
    'text'
  elsif /timestamp/i.match?(raw_data_type)
    'timestamp'
  elsif /boolean/i.match?(raw_data_type)
    'boolean'
  else
    raw_data_type.gsub(',', '')
  end
end


def main(input_file_name, output_file_name)
  tables = []
  alters = []

  table = ''
  alter = ''
  continue_grabbing_table = false
  continue_grabbing_alter = false
  File.foreach(input_file_name) do |line|
    next if useless?(line)
    if continue_grabbing_table
      table += line
      if ((line.scan(')').count > line.scan('(').count) || line.include?(';'))
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
    table_name = get_table_name_from_create(t)
    attrs = t.split("\n")[1...-1]
    attr_pairs = get_column_data(attrs)
    output_file.write("\t#{table_name} {\n")
    attr_pairs.each do |data_type, column_name|
      output_file.write("\t\t#{data_type} #{column_name}\n")
    end
    output_file.write("\t}\n")
  end
  alters.each do |a|
    if a.include?('FOREIGN KEY')
      table_name = get_table_name_from_alter(a)
      fk_table_name = get_fk_table_name_from_alter(a)
      output_file.write("\t#{table_name} }|--|| #{fk_table_name} : \"\"\n")
    end
  end
  output_file.close
end

main(ARGV[0], ARGV[1])
