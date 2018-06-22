data = []
File.open("notas.csv", "r") { |file| data= file.readlines }

print data.map(&:chomp)

def promedios(hashito)
  lines = hashito.map(&:chomp)
  nota = File.open("promedios.csv", 'w')
  lines.each do |value|
    promedio = value.split(',')
    sum = 0
    cont = 0
	    promedio.each do
	      if promedio[cont].to_i.is_a? Integer
	      	sum += promedio[cont].to_i 
	      end
	      	cont += 1
	    end
	valor = sum.to_f/(promedio.length - 1)    
    nota.puts "#{promedio[0]}: #{valor}"
  end
  nota.close
  return "\nArchivo generado correctamente\n "
end

def inasistencias(hashito)
	 lines = hashito.map(&:chomp)
	 total = 0
	 lines.each do |value|
    	promedio = value.split(',')
	 	numero = promedio.select{|i| /A/.match(i)}.to_a
	 	puts "#{promedio[0]} tiene #{numero.length} inasistencias "
	 	total += numero.length.to_i
	 	end
	 puts "\nTOTAL de inasitencias: #{total}"
end

def aprobados(hashito, min)
	lines = hashito.map(&:chomp)
	lines.each do |value|
    promedio = value.split(',')
    sum = 0
    cont = 0
	    promedio.each do
	      if promedio[cont].to_i.is_a? Integer
	      	sum += promedio[cont].to_i 
	      end
	      	cont += 1
	    end
	valor = sum.to_f/(promedio.length - 1) 
    	puts "#{promedio[0]}: #{valor}" if valor >= min.to_i
  end
end

puts "\nsistema de notas\n "
option = 0

while option!= 4
	puts "Ingrese 1 para crear archivo con promedio de los alumnos"
	puts "Ingrese 2 para ver inasistencias"
	puts "Ingrese 3 para ver aprobados"
	puts "Ingrese 4 para salir"

	option = gets.chomp
	
	case option.to_i
	when 1
		puts promedios(data)
	when 2
		inasistencias(data)
		puts "\n "
	when 3
		min = 5
		while min != 0
			puts "Ingrese nota minima de aprobacion (entre 1 y 10):\n"
			min = gets
			if  min.to_i > 0 && min.to_i <11
				puts "Alumnos aprobados:\n"
				aprobados(data,min)
				puts "\n "
				break
			else
				puts "Nota Ingresada no valida\nNOTA POR DEFECTO 5\nAlumnos aprobados:\n"
				min = 5
				aprobados(data,min)
				puts "\n "
				break
			end
		end
	when 4
		break
	else
		puts " \n\nLa opcion ingresada no es valida\n "
	end
	break if option==4
end