
$ENV{'DIRMAESTRO'} = "maestro";
$ENV{'DIRREPORTES'} = "reportes";


use Switch;

my $option;
system clear;
&validateIfEnvironmentIsInit();
#&showReportList();
&showOutputOptions();

sub showReportList{
	system clear;
	while ($option ne "x") {
		printf "%16s", "Listado de Reportes:\n";
		printf "%10s %16s", "(1)", "Listado por entidad origen\n";
		printf "%10s %16s", "(2)", "Listado por entidad destino\n";
		printf "%10s %16s", "(3)", "Balance por entidad\n";
		printf "%10s %16s", "(4)", "Listado por CBU\n";
		printf "%10s %5s", "(x)", "Salir\n";

		$option = &readFromConsole();
		switch($option){
			case "1"{
				&showListByOriginEntityFilters();
				exit;
			}
			case "2"{
				&showListByOriginEntityFilters();
				exit;	
			}
			case "3"{
				&showEntityBalanceFilters();
				exit;
			}
			case "4"{
				&showListByCbuFilters();
				exit;	
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

sub validateIfEnvironmentIsInit{
	if(!defined $ENV{'DIRMAESTRO'} || !defined $ENV{'DIRREPORTES'}){
		print "El ambiente no se encuentra inicializado. Por favor ejecute el comando Init\n";
		exit;
	}
	$masters = $ENV{'DIRMAESTRO'};
	$reports = $ENV{'DIRREPORTES'};
}

sub showInvalidOption{
	print "La opción: @_[0] no es válida\n";
}

sub showListByOriginEntityFilters{
	@originParams = &showOriginEntitiesFilters();
	@destParams = &showDestiniEntitiesFilters();
	@rangeImportParams = &showImportFilters();
	@stateParams = &showStateFilters();
	@sourceParams = &showSourceFilters();
	@outputParams = &showOutputOptions();

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
	if(@sourceParams){
		print "Fuentes: @sourceParams\n";
	}
	if(@outputParams){
		print "outputParams: @outputParams\n";
	}
}

sub showEntityBalanceFilters{
	@entityParam = &showBalanceEntityFilters();
	@rangeImportParams = &showImportFilters();
	@stateParams = &showStateFilters();
	@sourceParams = &showSourceFilters();
	@outputParams = &showOutputOptions();

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
	if(@sourceParams){
		print "Fuentes: @sourceParams\n";
	}
	if(@outputParams){
		print "outputParams: @outputParams\n";
	}
}

sub showListByCbuFilters{
	$cbuParam = &showCbuFilters();
	@originParams = &showOriginEntitiesFilters();
	@destParams = &showDestiniEntitiesFilters();
	@rangeImportParams = &showImportFilters();
	@stateParams = &showStateFilters();
	@sourceParams = &showSourceFilters();
	@outputParams = &showOutputOptions();

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
	if(@sourceParams){
		print "Fuentes: @sourceParams\n";
	}
	if(@outputParams){
		print "outputParams: @outputParams\n";
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
	}
}

sub showBalanceEntityFilters{
	print("Seleccione la entidad para la cual desea generar el balance\n");
		
	my $selectedEntity;
	my $finalize = 0;
	open(INPUTFILE,"<$masters/bamae.txt") || die "Error abriendo el archivo de maestros\n";
	@lines = <INPUTFILE>;
	close (INPUTFILE);
	while(!$finalize){
		system clear;
		print("Ingrese el número correspondiente al banco deseado seguido de la tecla enter. Para cancelar presione (f)\n");
		
		my $invalidOption = 1;
		do{
			my $option = &readFromConsole();
			my $optionCount = ($#lines + 1);
			if(&isANumber($option) && &toNumber($option) <= $optionCount && &toNumber($option) >= 0){
				my ($abr, $code, $name) = split(";", @lines[$option]);
				$selectedEntity = $abr;
				$invalidOption = 0;
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
		while (!$finalize){
			print("Ingrese el rango de importes por el cual desea filtrar. Presione (f) si desea salir.\n");
			my $finalizeMinCharge = 0;
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

			while (!$finalize){
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
			};
		};
		if(&isANumber($minValue) && &isANumber($maxValue)){
			return ($minValue, $maxValue);
		}
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
	}
}

sub showSourceFilters{
	if(&validateYesOrNo("¿Desea filtrar por Fuente? S/N\n")){
		printf "%10s %16s", "(1)", "Todas las fuentes\n";
		printf "%10s %16s", "(2)", "Seleccionar fuentes\n";
		printf "%10s %16s", "(3)", "Ir al siguiente filtro\n";

		my $option = <STDIN>;
		chomp($option);
		switch($option){
			case "1"{
				if(&validateYesOrNo("¿Desea seleccionar todas las fuentes existentes? S/N\n")){

				}
			}
			case "2"{
				my $finalize = 0;
				my @sources;
				do{
					@sources = &listSourcesToFilter();
					if(!@sources){
						if(!&validateYesOrNo("No ha ingresado fuentes. ¿Desea seleccionar todas las fuentes? S/N\n")){
							#todo!
						}
					}else{
						print("Filtros ingresados: @sources\n");
						if(&validateYesOrNo("¿Desea continuar usando las fuentes ingresadas? S/N\n")){
							return @sources;
						}
					}
				}while (!@sources || $finalize); 
			}
			case "3"{
				
			}
			else{
				&showInvalidOption($option);
			}
		}
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
		do{
			system clear;
			printf "Ingrese las fuentes con el formato \"ddMMyyyy.txt\". Luego de cada fuente presione enter. Presione (f) para terminar la carga.\n";	

			if(keys %selectedFonts){
				print("Fuentes ingresadas: ");
				print "$_ " for (keys %selectedFonts);
				print "\n";
			}

			my $option = &readFromConsole();
			if($option eq "f"){
				if(keys %selectedFonts){
					if(!&validateYesOrNo("No ha ingresado fuentes. ¿Desea filtrar usando todas las fuentes? S/N\n")){
						$finalize = 1;
					}
				}
				
			}else{
				if(!exists $fonts{$option}){
					$selectedFonts{$option} = 1;
				}else{
					print "La fuente ya ha sido ingresada\n";
				}		
			}
		}while (!$finalize);
		return keys %selectedFonts;
}

sub showOutputOptions{
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
					return ("p");
				}
				case "2"{
					return ("sa");
				}
				case "3"{
					return ("p", "sa");
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