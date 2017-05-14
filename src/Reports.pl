use Switch;

$tranfer = "tranfer";

#parametros validos para invocacion
%parameters = 
	("-f" => 0
, "-rf" => 0
, "-u"  => 0
, "-o"  => 0
, "-d"  => 0
, "-e"  => 0
#, "-t"  => 0
#, "-rt" => 0
, "-ri" => 0
, "-cbu" => 0
);

#Toma los parametros tipo fecha que fueron ingresados
sub getDateParams {
	@dparams = ();
	while( $i <= $#params && !exists($parameters{"@params[$i]"})){
		if(@params[$i] =~ /[0-9]{8,8}/){
			push(@dparams,@params[$i]);
		}else{
			print "@params[$i] no es una fecha valida!!\n";
			exit;
		}
		$i++;
	}	
	if ($#dparams >= 0){ #Si tengo parametros de fecha => voy a quedar desfasado en el ciclo desfasado y tengo que volver atras
		$i--;	
	}
	return @dparams;
}

#Toma los parametros tipo importe que fueron ingresados
sub getImportParams {
	@iparams = ();
	while( $i <= $#params && !exists($parameters{"@params[$i]"})){
		if(@params[$i] =~ /[0-9]*,?[0-9]{2}/){
			push(@iparams,@params[$i]);
		}else{
			print "@params[$i] no es un importe valido!!\n"; 	
			exit;
		}
		$i++;
	}	
	if ($#iparams >= 0){ #Si tengo parametros de importe => voy a quedar desfasado en el ciclo desfasado y tengo que volver atras
		$i--;	
	}
	return @iparams;
}

#Toma los parametros de estado que fueron ingresados
sub getStateParams {
	@eparams = ();
	while( $i <= $#params && !exists($parameters{"@params[$i]"})){ 
		if(@params[$i] eq "Pendiente" || @params[$i] eq "Anulada"){
			push(@eparams,@params[$i]);
		}
		else{
			print "@params[$i] no es un estado valido!!\n";
			exit;
		}
		$i++;
	}	
	if ($#eparams >= 0){ #Si tengo parametros de estado => voy a quedar desfasado en el ciclo desfasado y tengo que volver atras
		$i--;	
	}
	return @eparams;
}

#Toma los parametros de fuente que fueron ingresados
sub getSourceParams {
	@eparams = ();
	while( $i <= $#params && !exists($parameters{"@params[$i]"})){
		if(@params[$i] =~ /[0-9]{8,8}.txt/){
			push(@eparams,@params[$i]);
		}
		else{
			print "@params[$i] no es un nombre de archivo fuente valido!!\n";
			exit;
		}
		$i++;
	}	
	if ($#eparams >= 0){ #Si tengo parametros de estado => voy a quedar desfasado en el ciclo desfasado y tengo que volver atras
		$i--;	
	}
	return @eparams;
}

#Toma los parametros de origen y destino que fueron ingresados
sub getBanksParams {
	@eparams = ();
	while( $i <= $#params && !exists($parameters{"@params[$i]"})){
		push(@eparams,@params[$i]);
		$i++;
	}	
	if ($#eparams >= 0){ #Si tengo parametros de estado => voy a quedar desfasado en el ciclo desfasado y tengo que volver atras
		$i--;	
	}
	return @eparams;
}

sub getParameters {
	@params = @ARGV;

	for($i = 0; $i <= $#params; $i++){
		switch(@params[$i]){
			case "-f" { #Es filtro de fechas
				if(defined(@dateParams) || defined(@rangeDateParams)){
					print "No pueden agregarse dos parametros de fechas diferentes!\n";		
					exit;
				}
				$i++; # me muevo a la sigueinte posicion
				@dateParams = getDateParams();		
				$parameters{"-f"} = 1;
			}	
			case "-u" { #Es filtro de fuentes
				if(defined(@sourceParams)){
					print "No pueden agregarse dos parametros de fuentes diferentes!\n";		
					exit;
				}
				$i++; # me muevo a la sigueinte posicion
				@sourceParams = getSourceParams();	
				$parameters{"-u"} = 1;
			}
			case "-o" { #Es filtro de origines
				if(defined(@originParams)){
					print "No pueden agregarse dos parametros de banco origen diferentes!\n";		
					exit;	
				}
				$i++; # me muevo a la sigueinte posicion
				@originParams = getBanksParams();		
				$parameters{"-o"} = 1;
			}
			case "-d" { #Es filtro de destinos
				if(defined(@destParams)){
					print "No pueden agregarse dos parametros de banco destino diferentes!\n";		
					exit;	
				}
				$i++; # me muevo a la sigueinte posicion
				@destParams = getBanksParams();		
				$parameters{"-d"} = 1;
			}
			case "-e" { #Es filtro de estados
				if(defined(@stateParams)){
					print "No pueden agregarse dos parametros de estados diferentes!\n";		
					exit;
				}
				$i++; # me muevo a la sigueinte posicion
				@stateParams = getStateParams();		
				$parameters{"-e"} = 1;
			}
			case "-t" { #Es filtro de estados
				if(defined(@transferParams) || defined(@rangeTransferParams)){
					print "No pueden agregarse dos parametros de fechas fecha de transferencia diferentes!\n";		
					exit;	
				}
				$i++; # me muevo a la sigueinte posicion
				@transferParams = getDateParams();		
				$parameters{"-t"} = 1;
			}
			case "-rf" { #Es filtro de rango de fechas
				if(defined(@dateParams) || defined(@rangeDateParams)){
					print "No pueden agregarse dos parametros de fechas diferentes!\n";			
				}
				$i++; # me muevo a la sigueinte posicion
				@rangeDateParams = getDateParams();		
				if($#rangeDateParams != 1){
					print "No se ingreso un rango de fechas valido\n";
					exit;
				}
				$parameters{"-rf"} = 1;
			}
			case "-rt" { #Es filtro de rango de fechas de transferencia
				if(defined(@transferParams) || defined(@rangeTransferParams)){
					print "No pueden agregarse dos parametros de fecha de transferencia diferentes!\n";			
				}
				$i++; # me muevo a la sigueinte posicion
				@rangeTransferParams = getDateParams();		
				if($#rangeTransferParams != 1){
					print "No se ingreso un rango de fechas de transferencia valido\n";
					exit;			
				}
				$parameters{"-rt"} = 1;
			}
			case "-ri" { #Es filtro de rango de importes
				if(defined(@rangeImportParams)){
					print "No pueden agregarse dos parametros de importes diferentes!\n";		
					exit;	
				}
				$i++; # me muevo a la sigueinte posicion
				@rangeImportParams = getImportParams();
				if($#rangeImportParams != 1){
					print "No se ingreso un rango de importes valido\n";
					exit;			
				}
				$parameters{"-ri"} = 1;
			}
			case "-cbu" { #Es filtro de rango de importes
				if(defined($cbuParam)){
					print "No pueden agregarse dos parametros de cbu diferentes!\n";		
					exit;	
				}
				$i++; # me muevo a la sigueinte posicion
				if($i > $#ARGV){
					print "Debe ingresarse un número de cbu\n";
					exit;			
				}
				$cbuParam = @ARGV[$i];
				if(length($cbuParam) < 22){
					print "El número de cbu debe tener 22 dígitos\n";
					exit;				
				}
				$parameters{"-cbu"} = 1;
			}
			else {
				print "Parametro incorrecto!!\n";		
			}
		}
	}
}
sub showParameter{
	@plist = @{$_[0]};
	$pname = @_[1];
	if(defined(@plist) && $#plist >= 0){
		print "\t$pname: ";
		for(my $j = 0; $j <= $#plist; $j++){
			print "@plist[$j] ";				
		}
		print "\n";
	}
}

sub showRangeParameter{	
	@plist = @{$_[0]};
	$pname = @_[1];
	if(defined(@plist) && $#plist >= 0){
		print "\tRango de $pname: [@plist[0]; @plist[1]]\n";
	}
}

sub showParameters{
	print "Se utilizarán los siguientes filtros:\n";
	showParameter(\@dateParams, "fechas de transacción");
	showParameter(\@sourceParams, "fuentes");
	showParameter(\@originParams, "origenes");
	showParameter(\@destParams, "destinos");
	showParameter(\@statesParams, "estados");
	showParameter(\@transferParams, "fechas de transferencia");
	showRangeParameter(\@rangeDateParams, "fechas de transacción");
	showRangeParameter(\@rangeTransferParams, "fechas de transferencia");
	showRangeParameter(\@rangeImportParams, "importes");
}

#Retorna el nombre de todos los archivos de trabajo
sub getAllFileNames{
	while( $filename = readdir(DIRTRANS) ){
		if( $filename =~ /[0-9]{8,8}.txt/ ){ ##Recupero solo los archivos tipo txt
			push(@fileNames, "$filename");	
		}
	}		
}

#Retorna el nombre de todos los archivos que se correspondan con un rango de fechas
sub getFileNamesByRange{
	$dateFrom = @rangeDateParams[0];
	$dateTo = @rangeDateParams[1];
	
	while( $filename = readdir(DIRTRANS) ){
		$dateFileName = $filename;
		$dateFileName =~ s/.txt//;
		if($dateFileName ge $dateFrom && $dateFileName le $dateTo )	{
			push(@fileNames, "$filename");	
		}
	}		
}

#Retorna el nombre de todos los archivos que se correspondan con una lista de fechas
sub getFileNamesByList{
	while( $filename = readdir(DIRTRANS) ){
		$dateFileName = $filename;
		$dateFileName =~ s/.txt//;

		for( $i = 0; $i <= $#dateParams; $i++){
			if($dateFileName eq @dateParams[$i])	{
				push(@fileNames, "$filename");	
			}
		}
	}		
}

#Recupera los archivos a utlizar
sub getFileNames{
	#Recupero los archivos que voy a usar para trabajar segun las fechas ingresadas
	if(!opendir(DIRTRANS, $tranfer)) 
	{
		print "Se ha producido un error accediendo al directorio de datos\n"; 	
		exit;
	}
	@fileNames = ();#Array que contiene a los archivos con los que se van a generar los reportes
	
	if($parameters{"-rf"}){
		getFileNamesByRange();
	} elsif($parameters{"-f"}){
		getFileNamesByList();
	} else {
		getAllFileNames();
	}

	closedir(DIRTRANS);

	if( $#fileNames == -1 ){
		print "No se encontraron archivos para los filtros especificados\n";
		exit;
	}
}

sub showFileNames(){
	print "Se utilizarán los siguientes archivos:\n";
	for(my $j=0; $j <= $#fileNames; $j++){
		print "\t@fileNames[$j]\n";	
	}
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
		openInputFile(@fileNames[$j]);
		@lines = <INPUTFILE>;
		close (INPUTFILE);

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

	printf("\n");
	foreach my $bank (keys(%report)) {
		printf("Transferencias del banco %s hacia otras entidades bancarias\n", $bank);	
		printf("\n");
		printf("%-16s | %-15s | %-14s | Desde fecha: %-9s | Hasta Fecha: %-9s\n", "Banco Origen", $bank, "", $dateFrom, $dateTo);	
		printf ('%1$s'x101 . "\n", "-");
		printf("%-16s | %-15s | %-14s | %-22s | %-22s\n", "FECHA", "IMPORTE", "ESTADO", "ORIGEN", "DESTINO");	
		printf ('%1$s'x101 . "\n", "-");
		
		my $total = 0;

		foreach my $kdate (keys %{ $report{$bank} }) {
			my $subtotal = 0;
			for(my $i = 0; $i <= $#{$report{$bank}{$kdate}}; $i++){
				if($showDetails){
					printf("%16s | %15s | %-14s | %-22s | %-22s\n", $kdate, $report{$bank}{$kdate}[$i]{import}, $report{$bank}{$kdate}[$i]{state}, $report{$bank}{$kdate}[$i]{origin}, $report{$bank}{$kdate}[$i]{dest});	
					printf ('%1$s'x101 . "\n", "-");	
				}
				my $importSum = $report{$bank}{$kdate}[$i]{import};
				$importSum =~ s/,/./;
				$subtotal += $importSum;
			}
			#Subtotal por fecha
			my $day = $kdate;
			$day =~ s/[0-9]{6,6}//;
			
			printf ('%1$s'x101 . "\n", "-");
			printf("%-16s | %15.2f | %14s\n","subtotal día $day ", $subtotal);
			printf ('%1$s'x101 . "\n", "-");

			$total += $subtotal;
		}
		printf ('%1$s'x101 . "\n", "=");
		printf("%-16s | %15.2f | %14s\n","total general ", $total);
		printf ('%1$s'x101 . "\n", "=");

		printf("\n");
	}
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
		openInputFile(@fileNames[$j]);
		@lines = <INPUTFILE>;
		close (INPUTFILE);

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

	printf("\n");
	foreach my $bank (keys(%report)) {
		printf("Transferencias desde otras entidades hacia el banco %s \n", $bank);	
		printf("\n");
		printf("%-16s | %-15s | %-14s | Desde fecha: %-9s | Hasta Fecha: %-9s\n", "Banco Origen", $bank, "", $dateFrom, $dateTo);	
		printf ('%1$s'x101 . "\n", "-");
		printf("%-16s | %-15s | %-14s | %-22s | %-22s\n", "FECHA", "IMPORTE", "ESTADO", "ORIGEN", "DESTINO");	
		printf ('%1$s'x101 . "\n", "-");
		
		my $total = 0;

		foreach my $kdate (keys %{ $report{$bank} }) {
			my $subtotal = 0;
			for(my $i = 0; $i <= $#{$report{$bank}{$kdate}}; $i++){
				if($showDetails){
					printf("%16s | %15s | %-14s | %-22s | %-22s\n", $kdate, $report{$bank}{$kdate}[$i]{import}, $report{$bank}{$kdate}[$i]{state}, $report{$bank}{$kdate}[$i]{origin}, $report{$bank}{$kdate}[$i]{dest});	
					printf ('%1$s'x101 . "\n", "-");	
				}
				my $importSum = $report{$bank}{$kdate}[$i]{import};
				$importSum =~ s/,/./;
				$subtotal += $importSum;
			}
			#Subtotal por fecha
			my $day = $kdate;
			$day =~ s/[0-9]{6,6}//;
			
			printf ('%1$s'x101 . "\n", "-");
			printf("%-16s | %15.2f | %14s\n","subtotal día $day ", $subtotal);
			printf ('%1$s'x101 . "\n", "-");

			$total += $subtotal;
		}
		printf ('%1$s'x101 . "\n", "=");
		printf("%-16s | %15.2f | %14s\n","total general ", $total);
		printf ('%1$s'x101 . "\n", "=");

		printf("\n");
	}
}

sub listByCbu{
	$cbu = @_[0];
	print "$cbu\n";
	@fileNames = sort(@fileNames); #ordeno los archivos por fecha para su tratamiento

	printf("\n");
	printf("Transferencias de la cuenta: %s\n", $cbu); #titulo
	printf ('%1$s'x101 . "\n", "=");
	printf("%-16s | %-15s | %-14s | %-22s | %-22s\n", "FECHA", "IMPORTE", "ESTADO", "DESDE", "HACIA");	
	printf ('%1$s'x101 . "\n", "=");

	%totalControl = (debit => 0, credit => 0);
	for($j = 0; $j <= $#fileNames; $j++){
		openInputFile(@fileNames[$j]);
		@lines = <INPUTFILE>;
		close (INPUTFILE);
		
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
						printf("%16s | %15s | %-14s | %22s | %22s\n",$date, $import, $state, $cbuOrigin, $cbuDest);
					}
				}
			}

			#Muestro el subtotal
			$subtotal = $subtotalControl{credit} - $subtotalControl{debit};
			printf ('%1$s'x101 . "\n", "-");
			printf("%-16s | %15.2f | %14s | %22s | %22s\n","subtotal día $day ", $subtotal, $total, "para la cuenta", $cbu);
			printf ('%1$s'x101 . "\n", "-");

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
	printf ('%1$s'x101 . "\n", "-");
	printf("%-16s | %15.2f | %14s | %22s | %22s\n","Balance $resultadoBalance", $total, "para la cuenta", $cbu);
	printf ('%1$s'x101 . "\n", "=");
	printf("\n");
}

sub balanceByEntity{
	
}

sub balanceBetweenEntities{
	$entity1 = @_[0];
	$entity2 = @_[1];
}

sub rankingBetweenEntities{
}

sub openInputFile{
	open(INPUTFILE,"<$tranfer/@_[0]") || die "Error";
}

#Divide la linea en los valores de interes
sub splitLine{
	$line = @_[0];	
	chomp($line);
	($source, $origin, $originCode, $dest, $destCode, $date, $import, $state, $cbuOrigin, $cbuDest) = split(";",$line);
	return isAValidLine(); 
}

#Retorna 1 si la linea que se acaba de dividir cumple con los parametros y 0 sino
sub isAValidLine{
	$isValid = 0;
	if($parameters{"-f"}){
		$isValid = 0;
		for($t = 0; $t <= $#dateParams; $t++){
			if(@dateParams[$t] eq $date){
				$isValid = 1;
			}
		}		
		if(!$isValid){
			return 0;		
		}
	}

	if($parameters{"rf"}){
		my $df = @rangeDateParams[0];
		my $dt = @rangeDateParams[1];		
		if($date < $df || $dt < $date){
			return 0;
		}
	}

	if($parameters{"-o"}){
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

	if($parameters{"-d"}){
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

	if($parameters{"-e"}){
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

	if($parameters{"-ri"}){
		my $if = @rangeImportParams[0];
		my $it = @rangeImportParams[1];		
		if($import < $if || $it < $import){
			return 0;
		}
	}
	return 1;
}

sub pedirFiltros(){
	while($filtro not eq "x"){
		print "\t Filtros disponibles\n";
		print "(-u) \t Fuente \n ";
		print "(-o) \t Entidad origen  \n ";
		print "(-d) \t Entidad destino \n ";
		print "(-e) \t Estado \n ";
		print "(-f) \t Fecha \n ";
		print "(-rf)\t Rango de fechas \n ";
		print "(-ri) \t Importe \n ";
		print "(-eb) \t Entidad balance\n ";
		print "(-cbu) \t CBU \n ";
		print "(x) \t Volver \n ";
		$filtro = <STDIN>;
		print $filtro;
		chomp $filtro;
		print $filtro;
	}	
}

sub menu{
	$option = "";
	@filtros;
	@opListado;
	while( 1 ){
		print "\tMenu de Reportes\t \n";
		print "(1) \tListado por entidad origen\n";
		print "(2) \tListado por entidad destino\n";
		print "(3) \tBalance por entidad\n";
		print "(4) \tListado por CBU\n";
		print "(x) \tSalir\n";
		$option = <STDIN>;
		chomp $option;

		switch($option){
			case "1" { 
				@filtros = pedirFiltros();
				#@opListado = pedirOpcionesListado();
				#Llamar a la funcion que da el listado por entidad origen, pasarle los 2 array 
			}
			case "2" {
			}
			case "3" {
			}
			case "4" {
			}
			case "x" { 
				exit;
			}
		}
		
	}
	
}

##########INICIO DE EJECUCION##########

system 'clear'; #Limpio la pantalla

menu();

getParameters(); #Otengo los parametros

showParameters(); #Muestro los parametros

getFileNames(); #Obtengo los archivos a utilizar

showFileNames(); #Muestro los archivos fuente que fueron encontrados segun los filtros

#listByCbu("0030032120005404458661");

#listByDestinationEntity(0);
balanceByEntity();
