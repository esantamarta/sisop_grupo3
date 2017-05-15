
$ENV{'DIRMAESTRO'} = "maestro";
$ENV{'DIRREPORTES'} = "reportes";
$ENV{'DIRPROCESADOS'} = 'tranfer';


use Switch;

my $option;
system clear;
&validateIfEnvironmentIsInit();
&showReportList();


sub showReportList{
	system clear;
	while ($option ne "x") {
		printf "%16s", "Listado de Reportes:\n";
		printf "%10s %16s", "(1)", "Listado por entidad origen\n";
		printf "%10s %16s", "(2)", "Listado por entidad origen con detalles\n";
		printf "%10s %16s", "(3)", "Listado por entidad destino\n";
		printf "%10s %16s", "(4)", "Listado por entidad destino con detalles\n";
		printf "%10s %16s", "(5)", "Balance por entidad\n";
		printf "%10s %16s", "(6)", "Listado por CBU\n";
		printf "%10s %5s", "(h)", "Ayuda\n";
		printf "%10s %5s", "(x)", "Salir\n";

		$option = &readFromConsole();
		switch($option){
			case "1"{
				&showListByOriginEntityFilters();
				&listByOriginEntity(0);
				exit;
			}
			case "2"{
				&showListByOriginEntityFilters();
				&listByOriginEntity(1);
				exit;
			}
			case "3"{
				&showListByOriginEntityFilters();
				&listByDestinationEntity(0);
				exit;	
			}
			case "4"{
				&showListByOriginEntityFilters();
				&listByDestinationEntity(1);
				exit;	
			}
			case "5"{
				&showEntityBalanceFilters();
				&balanceByEntity();
				exit;
			}
			case "6"{
				&showListByCbuFilters();
				&listByCbu();
				exit;	
			}
			case "h"{
				&showHelp();
				&showReportList();
			}
			case "x"{
				exit;
			}
			else{
				&showInvalidOption($option);
			}
		}

	}
}

sub showHelpMenu{
	printf "%16s", "Menú de ayuda:\n";
	printf "%10s %16s", "(1)", "Listado por entidad origen\n";
	printf "%10s %16s", "(2)", "Listado por entidad origen con detalles\n";
	printf "%10s %16s", "(3)", "Listado por entidad destino\n";
	printf "%10s %16s", "(4)", "Listado por entidad destino con detalles\n";
	printf "%10s %16s", "(5)", "Balance por entidad\n";
	printf "%10s %16s", "(6)", "Listado por CBU\n";
	printf "%10s %5s", "(x)", "Volver al menú principal\n";
}

sub closeHelp{
	my $option;
	while (1) {
		$option = &readFromConsole();
		if($option eq "b"){
			&showHelp();
		}
		if($option eq "x"){
			&showReportList();
		}
	}
}

sub showHelp{
	my $option;
	system clear;
	do{
		showHelpMenu();		
		$option = &readFromConsole();
		switch($option){
			case "1"{
				system clear;
				printf('%1$s'x101 . "\n", "-");
				print("Listado por entidad origen\n");
				printf('%1$s'x101 . "\n", "-");
				printf('%1$s'x101 . "\n", "-");
				print("Lista el importe total de las transferencias emitidas por un banco que cumplen con los parámetros \n");
				print("de invocación.\n");
				print("Se puede solicitar listar las transferencias de un banco, varios bancos o todos los bancos\n");
				print("No considera las transferencias efectuadas dentro de la misma entidad\n");
				printf('%1$s'x101 . "\n", "-");
				print("Acepta los siguientes parámetros:\n");
				printf("%10s %s", "*", "Entidad Origen: una, varias o todas\n");
				printf("%10s %s", "*", "Entidad Destino: una, varias o todas\n");
				printf("%10s %s", "*", "Rango de importes: dos números reales positivos\n");
				printf("%10s %s", "*", "Estados: Anulada o Pendiente\n");
				printf("%10s %s", "*", "Fuentes: uno, varios o todos los archivos fuente para el reporte\n");
				print("Se le puede especificar que la salida sea por consola, a archivo o por consola y archivo\n");
				print("En el caso de especificar la creación de un archivo de salida, este se guardará en el directorio:\n"); 
				print("Listados dentro del directorio definido para los reportes\n");

				printf('%1$s'x101 . "\n", "-");
				printf "%10s %5s", "(b)", "Volver al menú anterior\n";
				printf "%10s %5s", "(x)", "Volver al menú principal\n";
				&closeHelp();
			}
			case "2"{
				system clear;
				printf('%1$s'x101 . "\n", "-");
				print("Listado por entidad origen\n");
				printf('%1$s'x101 . "\n", "-");
				printf('%1$s'x101 . "\n", "-");
				print("Lista las transferencias emitidas por un banco que cumplen con los parámetros de invocación.\n");
				print("Se puede solicitar listar las transferencias de un banco, varios bancos o todos los bancos\n");
				print("No considera las transferencias efectuadas dentro de la misma entidad\n");
				printf('%1$s'x101 . "\n", "-");
				print("Acepta los siguientes parámetros:\n");
				printf("%10s %s", "*", "Entidad Origen: una, varias o todas\n");
				printf("%10s %s", "*", "Entidad Destino: una, varias o todas\n");
				printf("%10s %s", "*", "Rango de importes: dos números reales positivos\n");
				printf("%10s %s", "*", "Estados: Anulada o Pendiente\n");
				printf("%10s %s", "*", "Fuentes: uno, varios o todos los archivos fuente para el reporte\n");
				print("Se le puede especificar que la salida sea por consola, a archivo o por consola y archivo\n");
				print("En el caso de especificar la creación de un archivo de salida, este se guardará en el directorio:\n");
				print("Listados dentro del directorio definido para los reportes\n");

				printf('%1$s'x101 . "\n", "-");
				printf "%10s %5s", "(b)", "Volver al menú anterior\n";
				printf "%10s %5s", "(x)", "Volver al menú principal\n";
				&closeHelp();
			}
			case "3"{
				system clear;
				printf('%1$s'x101 . "\n", "-");
				print("Listado por entidad origen\n");
				printf('%1$s'x101 . "\n", "-");
				printf('%1$s'x101 . "\n", "-");
				print("Lista el importe total de las transferencias recibidas por un banco que cumplen con los parámetros\n");
				print("de invocación.\n");
				print("Se puede solicitar listar las transferencias de un banco, varios bancos o todos los bancos\n");
				print("No considera las transferencias efectuadas dentro de la misma entidad\n");
				printf('%1$s'x101 . "\n", "-");
				print("Acepta los siguientes parámetros:\n");
				printf("%10s %s", "*", "Entidad Origen: una, varias o todas\n");
				printf("%10s %s", "*", "Entidad Destino: una, varias o todas\n");
				printf("%10s %s", "*", "Rango de importes: dos números reales positivos\n");
				printf("%10s %s", "*", "Estados: Anulada o Pendiente\n");
				printf("%10s %s", "*", "Fuentes: uno, varios o todos los archivos fuente para el reporte\n");
				print("Se le puede especificar que la salida sea por consola, a archivo o por consola y archivo\n");
				print("En el caso de especificar la creación de un archivo de salida, este se guardará en el directorio:\n");
				print("Listados dentro del directorio definido para los reportes\n");

				printf('%1$s'x101 . "\n", "-");
				printf "%10s %5s", "(b)", "Volver al menú anterior\n";
				printf "%10s %5s", "(x)", "Volver al menú principal\n";
				&closeHelp();
			}
			case "4"{
				system clear;
				printf('%1$s'x101 . "\n", "-");
				print("Listado por entidad origen\n");
				printf('%1$s'x101 . "\n", "-");
				printf('%1$s'x101 . "\n", "-");
				print("Lista las transferencias recibidas por un banco que cumplen con los parámetros de invocación.\n");
				print("Se puede solicitar listar las transferencias de un banco, varios bancos o todos los bancos\n");
				print("No considera las transferencias efectuadas dentro de la misma entidad\n");
				printf('%1$s'x101 . "\n", "-");
				print("Acepta los siguientes parámetros:\n");
				printf("%10s %s", "*", "Entidad Origen: una, varias o todas\n");
				printf("%10s %s", "*", "Entidad Destino: una, varias o todas\n");
				printf("%10s %s", "*", "Rango de importes: dos números reales positivos\n");
				printf("%10s %s", "*", "Estados: Anulada o Pendiente\n");
				printf("%10s %s", "*", "Fuentes: uno, varios o todos los archivos fuente para el reporte\n");
				print("Se le puede especificar que la salida sea por consola, a archivo o por consola y archivo\n");
				print("En el caso de especificar la creación de un archivo de salida, este se guardará en el directorio:\n");
				print("Listados dentro del directorio definido para los reportes\n");

				printf('%1$s'x101 . "\n", "-");
				printf "%10s %5s", "(b)", "Volver al menú anterior\n";
				printf "%10s %5s", "(x)", "Volver al menú principal\n";
				&closeHelp();	
			}
			case "5"{
				system clear;
				printf('%1$s'x101 . "\n", "-");
				print("Balance por entidad\n");
				printf('%1$s'x101 . "\n", "-");
				printf('%1$s'x101 . "\n", "-");
				print("Listar todas las transferencias recibidas y emitidas para una entidad e indica si el resultado fue\n");
				print("positivo o negativo.\n");
				print("Se puede solicitar listar las transferencias de un banco, varios bancos o todos los bancos\n");
				print("No considera las transferencias efectuadas dentro de la misma entidad\n");
				printf('%1$s'x101 . "\n", "-");
				print("Acepta los siguientes parámetros:\n");
				printf("%10s %s", "*", "Entidad: entidad sobre la que se quiere realizar el balance\n");
				printf("%10s %s", "*", "Rango de importes: dos números reales positivos\n");
				printf("%10s %s", "*", "Estados: Anulada o Pendiente\n");
				printf("%10s %s", "*", "Fuentes: uno, varios o todos los archivos fuente para el reporte\n");				
				print("Se le puede especificar que la salida sea por consola, a archivo o por consola y archivo\n");
				print("En el caso de especificar la creación de un archivo de salida, este se guardará en el directorio:\n");
				print("Listados dentro del directorio definido para los reportes\n");
				printf('%1$s'x101 . "\n", "-");
				printf "%10s %5s", "(b)", "Volver al menú anterior\n";
				printf "%10s %5s", "(x)", "Volver al menú principal\n";
				&closeHelp();
			}
			case "6"{
				system clear;
				printf('%1$s'x101 . "\n", "-");
				print("Listado por CBU\n");
				printf('%1$s'x101 . "\n", "-");
				printf('%1$s'x101 . "\n", "-");
				print("Listar las transferencias recibidas / emitidas por una determinada CBU que cumplen con los parámetros\n");
				print("de invocación.\n");
				printf('%1$s'x101 . "\n", "-");
				print("Acepta los siguientes parámetros:\n");
				printf("%10s %s", "*", "CBU: número de CBU sobre el que se quiere realizar el reporte\n");
				printf("%10s %s", "*", "Entidad Origen: una, varias o todas\n");
				printf("%10s %s", "*", "Entidad Destino: una, varias o todas\n");
				printf("%10s %s", "*", "Rango de importes: dos números reales positivos\n");
				printf("%10s %s", "*", "Estados: Anulada o Pendiente\n");
				printf("%10s %s", "*", "Fuentes: uno, varios o todos los archivos fuente para el reporte\n");
				print("Se le puede especificar que la salida sea por consola, a archivo o por consola y archivo\n");
				print("En el caso de especificar la creación de un archivo de salida, este se guardará en el directorio:\n");
				print("Listados dentro del directorio definido para los reportes\n");

				printf('%1$s'x101 . "\n", "-");
				printf "%10s %5s", "(b)", "Volver al menú anterior\n";
				printf "%10s %5s", "(x)", "Volver al menú principal\n";
				&closeHelp();
			}
			case "x"{
				&showReportList();
			}
			else{
				&showInvalidOption($option);
			}
		}
	}while($option ne "x");
}

sub validateIfEnvironmentIsInit{
	if(!defined $ENV{'DIRMAESTRO'} || !defined $ENV{'DIRREPORTES' ||!defined $ENV{'DIRPROCESADOS'}}){
		print "El ambiente no se encuentra inicializado. Por favor ejecute el comando Init\n";
		exit;
	}
	$masters = $ENV{'DIRMAESTRO'};
	$reports = $ENV{'DIRREPORTES'};
	$tranfer = $ENV{'DIRPROCESADOS'};
	$balances = "balances";
	$lists = "listados";
}

sub showInvalidOption{
	print "La opción: @_[0] no es válida\n";
}

sub showListByOriginEntityFilters{
	@originParams = &showOriginEntitiesFilters();
	@destParams = &showDestiniEntitiesFilters();
	@rangeImportParams = &showImportFilters();
	@stateParams = &showStateFilters();
	@fileNames = &showSourceFilters();
	%outputParams = &showOutputOptions();

	print ("\n");
	print ("\n");
	print ("Se utilizaron los siguientes filtros:");
	print ("\n");
	if(@originParams){
		print "Entidades origen: @originParams\n";
	}
	if(@destParams){
		print "Entidades destino: @destParams\n";
	}
	if(@rangeImportParams){
		print "Importes desde @rangeImportParams[0] hasta @rangeImportParams[0]\n";
	}
	if(@stateParams){
		print "Estados: @stateParams\n";
	}
	if(@fileNames){
		print "Fuentes: @fileNames\n";
	}
	if(%outputParams){
		if(exists $outputParams{"p"}){
			print "El reporte se mostrara por pantalla\n";
		}elsif(exists $outputParams{"sa"}){
			print "El reporte se guardará en un archivo\n";
		}else{
			print "El reporte se mostrara por pantalla y se guardará en un archivo\n";
		}
	}
}

sub showEntityBalanceFilters{
	%entityParam = &showBalanceEntityFilters();
	@rangeImportParams = &showImportFilters();
	@stateParams = &showStateFilters();
	@fileNames = &showSourceFilters();
	%outputParams = &showOutputOptions();

	print ("\n");
	print ("\n");
	print ("Se utilizaron los siguientes filtros:");
	print ("\n");

	if(@originParams){
		print "Entidades origen: @originParams\n";
	}
	if(@destParams){
		print "Entidades destino: @destParams\n";
	}
	if(@rangeImportParams){
		print "Importes desde @rangeImportParams[0] hasta @rangeImportParams[1]\n";
	}
	if(@stateParams){
		print "Estados: @stateParams\n";
	}
	if(@fileNames){
		print "Fuentes: @fileNames\n";
	}
	if(%outputParams){
		if(exists $outputParams{"p"}){
			print "El reporte se mostrara por pantalla\n";
		}elsif(exists $outputParams{"sa"}){
			print "El reporte se guardará en un archivo\n";
		}else{
			print "El reporte se mostrara por pantalla y se guardará en un archivo\n";
		}
	}
}

sub showListByCbuFilters{
	$cbuParam = &showCbuFilters();
	@originParams = &showOriginEntitiesFilters();
	@destParams = &showDestiniEntitiesFilters();
	@rangeImportParams = &showImportFilters();
	@stateParams = &showStateFilters();
	@fileNames = &showSourceFilters();
	%outputParams = &showOutputOptions();

	print ("\n");
	print ("\n");
	print ("Se utilizaron los siguientes filtros:");
	print ("\n");

	if($cbuParam){
		print "CBU: $cbuParam\n";
	}
	if(@originParams){
		print "Entidades origen: @originParams\n";
	}
	if(@destParams){
		print "Entidades destino: @destParams\n";
	}
	if(@rangeImportParams){
		print "Importes desde @rangeImportParams[0] hasta @rangeImportParams[1]\n";
	}
	if(@stateParams){
		print "Estados: @stateParams\n";
	}
	if(@fileNames){
		print "Fuentes: @fileNames\n";
	}
	if(%outputParams){
		if(exists $outputParams{"p"}){
			print "El reporte se mostrara por pantalla\n";
		}elsif(exists $outputParams{"sa"}){
			print "El reporte se guardará en un archivo\n";
		}else{
			print "El reporte se mostrara por pantalla y se guardará en un archivo\n";
		}
	}
}

sub showOriginEntitiesFilters{
	if(&validateYesOrNo("¿Desea filtrar por Entidad Origen? S/N\n")){
		printf "%10s %16s", "(1)", "Todas las entidades\n";
		printf "%10s %16s", "(2)", "Seleccionar entidades\n";
		printf "%10s %16s", "(3)", "Ir al siguiente filtro\n";

		my $option = &readFromConsole();
		switch($option){
			case "1"{
				if(&validateYesOrNo("¿Desea seleccionar todas las entidades origen de las cuales se tenga información? S/N\n")){
					return &getAllEntities();
				}
			}
			case "2"{
				my $finalize = 0;
				my @entities;
				do{
					@entities = &listEntitiesToFilter();
					if(!@entities){
						if(&validateYesOrNo("No ha ingresado filtros. Si no selecciona entidades origen no se generará el reporte. ¿Desea volver al listado de reportes? S/N\n")){
							&showReportList();
						}
					}else{
						return @entities;
					}
				}while (!@entities || $finalize); 
			}
			case "3"{
				
			}
			else{
				&showInvalidOption($option);
			}
		}
	}else{
		return &getAllEntities();
	}
}

sub showDestiniEntitiesFilters{
	if(&validateYesOrNo("¿Desea filtrar por Entidad Destino? S/N\n")){
		printf "%10s %16s", "(1)", "Todas las entidades\n";
		printf "%10s %16s", "(2)", "Seleccionar entidades\n";
		printf "%10s %16s", "(3)", "Ir al siguiente filtro\n";

		my $option = &readFromConsole();
		switch($option){
			case "1"{
				if(&validateYesOrNo("¿Desea seleccionar todas las entidades destino de las cuales se tenga información? S/N\n")){
					return &getAllEntities();
				}
			}
			case "2"{
				my $finalize = 0;
				my @entities;
				do{
					@entities = &listEntitiesToFilter();
					if(!@entities){
						if(&validateYesOrNo("No ha ingresado filtros. Si no selecciona entidades destino no se generará el reporte. ¿Desea volver al listado de reportes? S/N\n")){
							&showReportList();
						}
					}else{
						return @entities;
					}
				}while (!@entities || $finalize); 
			}
			case "3"{
				
			}
			else{
				&showInvalidOption($option);
			}
		}
	}else{
		return &getAllEntities();
	}
}

sub showBalanceEntityFilters{
	my $selectedEntity;
	my $finalize = 0;
	open(INPUTFILE,"<$masters/bamae.txt") || die "Error abriendo el archivo de maestros\n";
	@lines = <INPUTFILE>;
	close (INPUTFILE);
	while(!$finalize){
		system clear;
		print("Seleccione la entidad para la cual desea generar el balance\n");
		print("Ingrese el número correspondiente al banco deseado seguido de la tecla enter. Para cancelar presione (f)\n");
		
		for(my $i = 0; $i <= $#lines; $i++){
			my ($abr, $code, $name) = split(";", @lines[$i]);
			printf "%10s (%s) %s", "", "$i", "$abr\n";
		}
		printf "%10s (%s) %s", "", "f", "Cancelar\n";

		my $invalidOption = 1;
		do{
			my $option = &readFromConsole();
			my $optionCount = ($#lines + 1);
			if(&isANumber($option) && &toNumber($option) <= $optionCount && &toNumber($option) >= 0){
				my ($abr, $code, $name) = split(";", @lines[$option]);
				print "$abr\n";
				return ("abr" => $abr, "code" => $code);				
			}elsif ($option eq "f" || $option eq "F"){
				$finalize = 1;
				$invalidOption = 0;
			}else{
				&showInvalidOption($option);
			}
		}while ($invalidOption);
	}
	return $selectedEntity;
}

sub showImportFilters{
	if(&validateYesOrNo("¿Desea filtrar por rango de Importes? S/N\n")){
		my $finalize = 0;
		my $minValue;
		my $maxValue;
		my $finalizeMinCharge = 0;
		my $finalizeMaxCharge = 0;
		while (!$finalize){
			print("Ingrese el rango de importes por el cual desea filtrar. Presione (f) si desea salir.\n");
			while (!$finalizeMinCharge && !$finalize){
				print("Ingrese el mínimo importe:\n");
				$minValue = &readPositiveNumberFromConsole("f");
				if($minValue eq "f"){
					if(&validateYesOrNo("¿Desea abandonar la carga del filtro de Importes? S/N\n")){
						$finalize = 1;
					}
				}
				if(&isANumber($minValue)){
					$finalizeMinCharge = 1;
				}
			};

			while (!$finalizeMaxCharge && !$finalize){
				print("Ingrese el máximo importe:\n");
				$maxValue = &readPositiveNumberFromConsole("f");
				if($maxValue eq "f"){
					if(&validateYesOrNo("¿Desea abandonar la carga del filtro de Importes? S/N\n")){
						$finalize = 1;
					}
				}
				if(&isANumber($maxValue)){
					if(&toNumber($minValue) > &toNumber($maxValue)){
						print "El valor mínimo: $minValue ingresado es mayor al máximo: $maxValue\n";
					}else{
						$finalize = 1;
					}
				}
				if(&isANumber($maxValue)){
					$finalizeMaxCharge = 1;
				}
			};
		};
		if($finalizeMinCharge && $finalizeMaxCharge){
			return ($minValue, $maxValue);
		}
		return ();
	}else{
		return ();
	}
}

sub showStateFilters{
	if(&validateYesOrNo("¿Desea filtrar por Estados? S/N\n")){
		do{
			system clear;
			printf "%10s %9s", "(1)", "Anuladas\n";
			printf "%10s %10s", "(2)", "Pendientes\n";
			printf "%10s %10s", "(3)", "Anuladas y Pendientes\n";
			printf "%10s %10s", "(4)", "Ir al siguiente filtro\n";

			my $option = &readFromConsole();
			switch($option){
				case "1"{
					return ("Anulada");
				}
				case "2"{
					return ("Pendiente");
				}
				case "3"{
					return ("Anulada", "Pendiente");
				}
				case "4"{
					return 0;
				}
				else{
					&showInvalidOption($option);
				}
			}
		}while ();
	}else{
		return ("Anulada", "Pendiente");
	}
}

sub showSourceFilters{
	if(&validateYesOrNo("¿Desea filtrar por Fuente? S/N\n")){
		printf "%10s %16s", "(1)", "Todas las fuentes\n";
		printf "%10s %16s", "(2)", "Seleccionar fuentes\n";
		printf "%10s %16s", "(3)", "Ir al siguiente filtro\n";

		my $option = &readFromConsole();
		switch($option){
			case "1"{
				if(&validateYesOrNo("¿Desea seleccionar todas las fuentes existentes? S/N\n")){
					return &getAllFileNames();
				}else{
					return &showSourceFilters();
				}
			}
			case "2"{
				my $finalize = 0;
				my @sources;
				return &listSourcesToFilter();				
			}
			case "3"{
				
			}
			else{
				&showInvalidOption($option);
			}
		}
	}else{
		return &getAllFileNames();
	}
}

sub showCbuFilters{
	system clear;
	do{		
		print "Ingrese el número de CBU para filtrar seguido de la tecla enter para terminar la carga. Presione (f) si desea cancelar\n";
		my $cbuNumber = &readFromConsole();
		if($cbuNumber eq "f"){
			if(&validateYesOrNo("El filtro por cbu es obligatorio para este reporte, ¿Desea cancelar la generación? S/N\n")){
				&showReportList();
			}
		}elsif($cbuNumber =~ /[0-9]{22,22}/){
			return $cbuNumber;
		}else{
			print "El formato del CBU es incorrecto, el mismo consta de 22 dígitos\n";
		}
	}while (1);
}
	
sub listSourcesToFilter{
	my %selectedFonts;
	my $finalize = 0;

	system clear;
	printf "Ingrese las fuentes con el formato \"yyyyMMdd.txt\". Luego de cada fuente presione enter. Presione (f) para terminar la carga.\n";	

	do{
		if(keys %selectedFonts){
			print("Fuentes ingresadas: ");
			print "$_ " for (keys %selectedFonts);
			print "\n";
		}

		my $isValidInput = 0;
		do{
			my $option = &readFromConsole();
			if($option eq "f"){
				if(!keys %selectedFonts){
					if(&validateYesOrNo("No ha ingresado fuentes. ¿Desea filtrar usando todas las fuentes? S/N\n")){
						return &getAllFileNames();
					}else{
						if(&validateYesOrNo("No puede generar un reporte sin fuentes. ¿Desea ir al listado de reportes? S/N\n")){
							&showReportList();
						}
					}
				}else{
					if(!&validateYesOrNo("¿Desea continuar cargando fuentes? S/N\n")){
						return keys %selectedFonts;
						$finalize = 1;
					}
					$isValidInput = 1;
				}				
			}else{
				if(!exists $fonts{$option}){
					if(&existsSourceFile($option)){
						$selectedFonts{$option} = 1;
						$isValidInput = 1;
					}else{
						print "No existe el archivo fuente $option\n";
						$isValidInput = 0;
					}
				}else{
					print "La fuente ya ha sido ingresada\n";
					$isValidInput = 0;
				}		
			}
		}while (!$isValidInput);
	}while (!$finalize);
	return keys %selectedFonts;
}

sub showOutputOptions{
	my %outputOptions;
	do{
		system clear;
		print "Seleccione el modo en que desea que se muestre el reporte\n";
		printf "%10s %9s", "(1)", "Salida por Pantalla\n";
		printf "%10s %10s", "(2)", "Salida a Archivo\n";
		printf "%10s %10s", "(3)", "Salida por Pantalla y a Archivo\n";
		printf "%10s %8s", "(4)", "Cancelar reporte\n";

		my $option = &readFromConsole();
		switch($option){
			case "1"{
					$outputOptions{"p"} = 1;
				}
				case "2"{
					$outputOptions{"sa"} = 1;
				}
				case "3"{
					$outputOptions{"sao"} = 1;
				}
				case "4"{
					if(&validateYesOrNo("¿Quiere cancelar la generación del reporte? S/N\n")){
						&showReportList();
					}
				}
				else{
					&showInvalidOption($option);
				}
			}
		}while ();
	return %outputOptions;
}

sub readPositiveNumberFromConsole{
	my $scapeInput = @_[0];
	my $finalize = 0;
	do{
		my $input = &readFromConsole();
		if($scapeInput eq $input){
			return $scapeInput;
		}
		if(&isANumber($input)){
			return toNumber($input);
		}
		if(!&isANumber($input)){
			print("El valor ingresado no es un número\n");
		}elsif(toNumber($input) < 0){
			print("El valor debe ser un numero positivo\n");
		}else{
			$finalize = 1;
		}
	}while (!$finalize);
}

sub validateYesOrNo{
	do{
		print(@_[0]);
		my $option = <STDIN>;
		chomp($option);
		if($option eq "S" || $option eq "s"){
			return 1;
		}elsif ($option eq "N" || $option eq "n"){
			return 0;
		}else{
			&showInvalidOption($option);	
		}
	}while(1);
}

sub getAllEntities{
	open(INPUTFILE,"<$masters/bamae.txt") || die "Error abriendo el archivo de maestros\n";
	@lines = <INPUTFILE>;
	close (INPUTFILE);
	my @entities;
	for(my $i = 0; $i <= $#lines; $i++){
		my ($abr, $code, $name) = split(";", @lines[$i]);
		push(@entities, $abr);
	}
	return @entities;
}

sub listEntitiesToFilter{
	my %selectedEntities;
	my $finalize = 0;
	open(INPUTFILE,"<$masters/bamae.txt") || die "Error abriendo el archivo de maestros\n";
	@lines = <INPUTFILE>;
	close (INPUTFILE);
	while(!$finalize){
		system clear;

		if(keys %selectedEntities){
			print("Filtros ingresados: ");
			print "$_ " for (keys %selectedEntities);
			print "\n";
		}
		print("Ingrese el número correspondiente al banco deseado seguido de la tecla enter para terminar la carga, presione (f)\n");
		for(my $i = 0; $i <= $#lines; $i++){
			my ($abr, $code, $name) = split(";", @lines[$i]);

			if(!exists $selectedEntities{$abr}){
				printf "%10s (%s) %s", "", "$i", "$abr\n";
			}
		}
		printf "%10s (%s) %s", "", "f", "Terminar la carga\n";

		my $invalidOption = 1;
		do{
			my $option = &readFromConsole();
			my $optionCount = ($#lines + 1);
			if(&isANumber($option) && &toNumber($option) <= $optionCount && &toNumber($option) >= 0){
				my ($abr, $code, $name) = split(";", @lines[$option]);
				$selectedEntities{$abr} = 1;
				$invalidOption = 0;
			}elsif ($option eq "f" || $option eq "F"){
				my @entities = keys %selectedEntities;
				print("Filtros ingresados: @entities\n");
				if(&validateYesOrNo("¿Desea finalizar la carga de entidades? S/N\n")){
					$finalize = 1;
				}
				$invalidOption = 0;	
			}else{
				&showInvalidOption($option);
			}
		}while ($invalidOption);
	}
	return keys %selectedEntities;
}


sub readFromConsole{
	my $option = <STDIN>;
	chomp $option;
	return $option;
}

sub isANumber{
	my $value = @_[0];
	if( $value eq $value+0 ){
	  return 1;
	}
	return 0;
}

sub toNumber{
	my $value = @_[0];
	return $value+0;
}

#Retorna el nombre de todos los archivos de trabajo
sub getAllFileNames{
	my @fileNames;

	#Recupero los archivos que voy a usar para trabajar segun las fechas ingresadas
	if(!opendir(DIRTRANS, $tranfer)) 
	{
		print "Se ha producido un error accediendo al directorio de datos\n"; 	
		exit;
	}

	while( $filename = readdir(DIRTRANS) ){
		if( $filename =~ /[0-9]{8,8}.txt/ ){ ##Recupero solo los archivos tipo txt
			push(@fileNames, "$filename");	
		}
	}		

	closedir(DIRTRANS);

	if( $#fileNames == -1 ){
		print "No se encontraron archivos fuente\n";
		exit;
	}

	return @fileNames;
}

#Retorna 1 si existe un archivo fuente con el nombre indicado
sub existsSourceFile{
	my $name = @_[0];
	foreach my $fileName (&getAllFileNames()){
		if($name eq $fileName){
			return 1;
		}
	}
	return 0;
}

#Genera un timestamp para darle como nombre al reporte de salida
sub getLoggingTime {
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime(time);
    my $nice_timestamp = sprintf ( "%04d%02d%02d%02d%02d%02d",
                                   $year+1900,$mon+1,$mday,$hour,$min,$sec);
    return $nice_timestamp;
}

#Segun los parametros indicados por el usuario, retorna la lista de las salidas para el reporte.
#Si no existen los directorios indicados, los intenta crear
sub prepareOutputs{
	use File::Path qw( make_path );
	my $folder = "$reports/@_[0]";
	my @outputs = ();
	if($outputParams{"sa"} || $outputParams{"sao"}){
		my $fileName = getLoggingTime();
		if (!-d "$folder") {
		    make_path $folder or die "Se ha producido un error creando el reporte: $folder. No se guardará el reporte en el archivo indicado.";
		}
		open(OUTPUTFILE,">$folder/$fileName.txt") || die "Error generando el archivo de salida. No se guardará el reporte en el archivo indicado.";
		push(@outputs, OUTPUTFILE);
		print "El reporte se guardará en el archivo: $fileName.txt\n";
	}
	if($outputParams{"sao"} || !$outputParams{"sa"}){
		push(@outputs, STDOUT);	
	}
	return @outputs;
}

sub closeOutputs{
	foreach $output (@_){
		if($output ne "STDOUT"){
			close $output;
		}
	}
}

sub getAllFileLines{
	open(INPUTFILE,"<$tranfer/@_[0]") || die "Error abriendo el archivo @_[0]";
	my @lines = <INPUTFILE>;
	close (INPUTFILE);
	return @lines;
}

#Divide la linea en los valores de interes
sub splitLine{
	my $line = @_[0];	
	chomp($line);
	($source, $origin, $originCode, $dest, $destCode, $date, $import, $state, $cbuOrigin, $cbuDest) = split(";",$line);
	return &isAValidLine(); 
}

#Retorna 1 si la linea que se acaba de dividir cumple con los parametros y 0 sino
sub isAValidLine{
	my $isValid = 0;
	
	if(@originParams){
		$isValid = 0;
		for(my $t = 0; $t <= $#originParams; $t++){
			if(@originParams[$t] eq $origin){
				$isValid = 1;
			}
		}
		if(!$isValid){
			return 0;		
		}
	}
	
	if(@destParams){
		$isValid = 0;
		for(my $t = 0; $t <= $#destParams; $t++){
			if(@destParams[$t] eq $origin){
				$isValid = 1;
			}
		}
		if(!$isValid){
			return 0;		
		}
	}
	
	if(@stateParams){
		$isValid = 0;
		for(my $t = 0; $t <= $#stateParams; $t++){
			if(@stateParams[$t] eq $state){
				$isValid = 1;
			}
		}
		if(!$isValid){
			return 0;		
		}
	}

	if(@rangeImportParams){
		my $if = @rangeImportParams[0];
		my $it = @rangeImportParams[1];		
		if($import < $if || $it < $import){
			return 0;
		}
	}
	return 1;
}

sub listByOriginEntity{
	my $showDetails = @_[0];
	@fileNames = sort(@fileNames); #ordeno los archivos por fecha para su tratamiento

	my $dateFrom;
	my $dateTo;
	if($#fileNames < 0){
		return;
	}elsif($#fileNames == 0){
		$dateFrom = @fileNames[0];
		$dateTo = @fileNames[0];
	}else{
		$dateFrom = @fileNames[0];
		$dateTo = @fileNames[$#fileNames];
	}
	$dateFrom =~ s/.txt//;
	$dateTo =~ s/.txt//;

	%report = ();

	for($j = 0; $j <= $#fileNames; $j++){
		my @lines = &getAllFileLines(@fileNames[$j]);
		
		if($#lines >= 0){
			for($k = 0; $k <= $#lines; $k++){
				if(splitLine(@lines[$k])){
					if($origin ne $dest){
						if(!exists($report{$origin})){
							$report{$origin} = {};
						}
						if(!exists($report{$origin}{$date})){
							$report{$origin}{$date} = [];
						}
						push(@{ $report{$origin}{$date} }, { import => $import, state => $state, origin => $origin, dest => $dest});
					}
				}
			}
		}
	}	


	my @outputs = prepareOutputs("$lists");
	for my $fh (@outputs) { printf $fh "\n"; };
	foreach my $bank (keys(%report)) {
		for my $fh (@outputs) { printf $fh "Transferencias del banco %s hacia otras entidades bancarias\n", $bank; };
		for my $fh (@outputs) { printf $fh "\n"; };
		for my $fh (@outputs) { printf $fh "%-16s | %-15s | %-14s | Desde fecha: %-9s | Hasta Fecha: %-9s\n", "Banco Origen", $bank, "", $dateFrom, $dateTo; };
		for my $fh (@outputs) { printf $fh '%1$s'x101 . "\n", "-"; };
		for my $fh (@outputs) { printf $fh "%-16s | %-15s | %-14s | %-22s | %-22s\n", "FECHA", "IMPORTE", "ESTADO", "ORIGEN", "DESTINO"; };
		for my $fh (@outputs) { printf $fh '%1$s'x101 . "\n", "-"; };
		
		my $total = 0;

		foreach my $kdate (keys %{ $report{$bank} }) {
			my $subtotal = 0;
			for(my $i = 0; $i <= $#{$report{$bank}{$kdate}}; $i++){
				if($showDetails){

					for my $fh (@outputs) { printf $fh "%16s | %15s | %-14s | %-22s | %-22s\n", $kdate, $report{$bank}{$kdate}[$i]{import}, $report{$bank}{$kdate}[$i]{state}, $report{$bank}{$kdate}[$i]{origin}, $report{$bank}{$kdate}[$i]{dest}; };
					for my $fh (@outputs) { printf $fh '%1$s'x101 . "\n", "-"; };
				}
				my $importSum = $report{$bank}{$kdate}[$i]{import};
				$importSum =~ s/,/./;
				$subtotal += $importSum;
			}
			#Subtotal por fecha
			my $day = $kdate;
			$day =~ s/[0-9]{6,6}//;
			

			for my $fh (@outputs) { printf $fh '%1$s'x101 . "\n", "-"; };
			for my $fh (@outputs) { printf $fh "%-16s | %15.2f | %14s\n","subtotal día $day ", $subtotal; };
			for my $fh (@outputs) { printf $fh '%1$s'x101 . "\n", "-"; };

			$total += $subtotal;
		}
		for my $fh (@outputs) { printf $fh '%1$s'x101 . "\n", "="; };
		for my $fh (@outputs) { printf $fh "%-16s | %15.2f | %14s\n","total general ", $total; };
		for my $fh (@outputs) { printf $fh '%1$s'x101 . "\n", "="; };
		for my $fh (@outputs) { printf $fh "\n"; };
	}
	closeOutputs(@outputs);

}

sub listByDestinationEntity{
	my $showDetails = @_[0];
	@fileNames = sort(@fileNames); #ordeno los archivos por fecha para su tratamiento
	
	my $dateFrom;
	my $dateTo;
	if($#fileNames < 0){
		return;
	}elsif($#fileNames == 0){
		$dateFrom = @fileNames[0];
		$dateTo = @fileNames[0];
	}else{
		$dateFrom = @fileNames[0];
		$dateTo = @fileNames[$#fileNames];
	}
	$dateFrom =~ s/.txt//;
	$dateTo =~ s/.txt//;

	%report = ();

	for($j = 0; $j <= $#fileNames; $j++){
		my @lines = &getAllFileLines(@fileNames[$j]);

		if($#lines >= 0){
			for($k = 0; $k <= $#lines; $k++){
				if(splitLine(@lines[$k])){
					if($origin ne $dest){
						if(!exists($report{$dest})){
							$report{$dest} = {};
						}
						if(!exists($report{$dest}{$date})){
							$report{$dest}{$date} = [];
						}
						push(@{ $report{$dest}{$date} }, { import => $import, state => $state, origin => $origin, origin => $origin});
					}
				}
			}
		}
	}	

	my @outputs = prepareOutputs("$lists");
	for my $fh (@outputs) { printf $fh "\n"; };
	foreach my $bank (keys(%report)) {
		for my $fh (@outputs) { printf $fh "Transferencias desde otras entidades hacia el banco %s \n", $bank; }; 
		for my $fh (@outputs) { printf $fh "\n"; }; 
		for my $fh (@outputs) { printf $fh "%-16s | %-15s | %-14s | Desde fecha: %-9s | Hasta Fecha: %-9s\n", "Banco Origen", $bank, "", $dateFrom, $dateTo; }; 	
		for my $fh (@outputs) { printf $fh '%1$s'x101 . "\n", "-"; }; 
		for my $fh (@outputs) { printf $fh "%-16s | %-15s | %-14s | %-22s | %-22s\n", "FECHA", "IMPORTE", "ESTADO", "ORIGEN", "DESTINO"; }; 
		for my $fh (@outputs) { printf $fh '%1$s'x101 . "\n", "-"; }; 
		
		my $total = 0;

		foreach my $kdate (keys %{ $report{$bank} }) {
			my $subtotal = 0;
			for(my $i = 0; $i <= $#{$report{$bank}{$kdate}}; $i++){
				if($showDetails){

					for my $fh (@outputs) { printf $fh "%16s | %15s | %-14s | %-22s | %-22s\n", $kdate, $report{$bank}{$kdate}[$i]{import}, $report{$bank}{$kdate}[$i]{state}, $report{$bank}{$kdate}[$i]{origin}, $report{$bank}{$kdate}[$i]{dest}; }; 
					for my $fh (@outputs) { printf $fh '%1$s'x101 . "\n", "-"; }; 

				}
				my $importSum = $report{$bank}{$kdate}[$i]{import};
				$importSum =~ s/,/./;
				$subtotal += $importSum;
			}
			#Subtotal por fecha
			my $day = $kdate;
			$day =~ s/[0-9]{6,6}//;
			

			for my $fh (@outputs) { printf $fh '%1$s'x101 . "\n", "-"; }; 
			for my $fh (@outputs) { printf $fh "%-16s | %15.2f | %14s\n","subtotal día $day ", $subtotal; }; 
			for my $fh (@outputs) { printf $fh '%1$s'x101 . "\n", "-"; }; 

			$total += $subtotal;
		}
		for my $fh (@outputs) { printf $fh '%1$s'x101 . "\n", "="; }; 
		for my $fh (@outputs) { printf $fh "%-16s | %15.2f | %14s\n","total general ", $total; }; 
		for my $fh (@outputs) { printf $fh '%1$s'x101 . "\n", "="; }; 

		for my $fh (@outputs) { printf $fh "\n"; }; 
	}
	closeOutputs(@outputs);
}

sub listByCbu{
	$cbu = @_[0];
	print "$cbu\n";
	@fileNames = sort(@fileNames); #ordeno los archivos por fecha para su tratamiento


	my @outputs = prepareOutputs("$lists");
	for my $fh (@outputs) { printf $fh "\n"; };
	for my $fh (@outputs) { printf $fh "Transferencias de la cuenta: %s\n", $cbu; }; #titulo
	for my $fh (@outputs) { printf $fh '%1$s'x101 . "\n", "="; };
	for my $fh (@outputs) { printf $fh "%-16s | %-15s | %-14s | %-22s | %-22s\n", "FECHA", "IMPORTE", "ESTADO", "DESDE", "HACIA"; };
	for my $fh (@outputs) { printf $fh '%1$s'x101 . "\n", "="; };


	%totalControl = (debit => 0, credit => 0);
	for($j = 0; $j <= $#fileNames; $j++){
		my @lines = &getAllFileLines(@fileNames[$j]);
		
		$day = @fileNames[$j];
		$day =~ s/.txt//;
		$day =~ s/[0-9]{6,6}//;

		if($#lines >= 0){
			%subtotalControl = (debit => 0, credit => 0);
			for($k = 0; $k <= $#lines; $k++){
				if(splitLine(@lines[$k])){
					if($cbuOrigin eq $cbu || $cbuDest eq $cbu){
						$importSum = $import;
						$importSum =~ s/,/./;
						if($cbuOrigin eq $cbu){
							$subtotalControl{debit} += $importSum;									
						}else{
							$subtotalControl{credit} += $importSum;									
						}	

						for my $fh (@outputs) { printf $fh "%16s | %15s | %-14s | %22s | %22s\n",$date, $import, $state, $cbuOrigin, $cbuDest; };

					}
				}
			}

			#Muestro el subtotal
			$subtotal = $subtotalControl{credit} - $subtotalControl{debit};

			for my $fh (@outputs) { printf $fh '%1$s'x101 . "\n", "-"; };
			for my $fh (@outputs) { printf $fh "%-16s | %15.2f | %14s | %22s | %22s\n","subtotal día $day ", $subtotal, $total, "para la cuenta", $cbu; };
			for my $fh (@outputs) { printf $fh '%1$s'x101 . "\n", "-"; };


			$totalControl{debit} += $subtotalControl{debit};
			$totalControl{credit} += $subtotalControl{credit};
		}
	}
	$total = $totalControl{credit} - $totalControl{debit};
	if($total >= 0){
		$resultadoBalance = "POSITIVO";
	}else{
		$resultadoBalance = "NEGATIVO";
	}

	for my $fh (@outputs) { printf $fh '%1$s'x101 . "\n", "-"; };
	for my $fh (@outputs) { printf $fh "%-16s | %15.2f | %14s | %22s | %22s\n","Balance $resultadoBalance", $total, "para la cuenta", $cbu; };
	for my $fh (@outputs) { printf $fh '%1$s'x101 . "\n", "="; };
	for my $fh (@outputs) { printf $fh "\n"; };
}

sub balanceByEntity{
	@fileNames = sort(@fileNames); #ordeno los archivos por fecha para su tratamiento
	
	my $entity = $entityParam{"abr"};
	my $entityCode = $entityParam{"code"};

	%balance = ( credit => 0, debit => 0);	
	for($j = 0; $j <= $#fileNames; $j++){
		my @lines = &getAllFileLines(@fileNames[$j]);

		if($#lines >= 0){
			for($k = 0; $k <= $#lines; $k++){
				if(splitLine(@lines[$k])){
					if($origin ne $dest){
						$importSum = $import;
						$importSum =~ s/,/./;
						if($origin eq $entity){
							$balance{debit}+=$importSum;
						}
						if($dest eq $entity){
							$balance{credit}+=$importSum;
						}
					}
				}
			}
		}
	}	

	my @outputs = prepareOutputs("$balances");
	for my $fh (@outputs) { printf $fh "\n"; }
	for my $fh (@outputs) { printf $fh "Balance de la entidad %s \n", $entity; }
	for my $fh (@outputs) { printf $fh "\n"; }
	for my $fh (@outputs) { printf $fh '%1$s'x73 . "\n", "-"; }
	for my $fh (@outputs) { printf $fh "%-30s | %-15.2f | %-21s \n", "Desde $entityCode", $balance{credit}, "hacia otras entidades"; }	
	for my $fh (@outputs) { printf $fh "%-30s | %-15.2f | %-21s \n", "Hacia $entityCode", $balance{debit}, "desde otras entidades"; }
	my $balanceResult = $balance{credit} - $balance{debit};
	my $balanceResultState = "POSITIVO";
	if($balanceResult < 0){
		$balanceResultState = "NEGATIVO";
	}
	for my $fh (@outputs) { printf $fh '%1$s'x73 . "\n", "-"; }
	for my $fh (@outputs) { printf $fh "%-30s | %-15s | %-21s \n", "Balance $balanceResultState para $entityCode", $balanceResult, ""; }
	for my $fh (@outputs) { printf $fh '%1$s'x73 . "\n", "-"; }
	
	for my $fh (@outputs) { printf $fh "\n"; }
	closeOutputs(@outputs);
}