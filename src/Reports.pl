use Switch;

###REMOVER ini:
$tranfer = "tranfer";
$ENV{'DIRMAESTRO'} = "maestro";
$ENV{'DIRREPORTES'} = "reportes";
$reports = $ENV{'DIRREPORTES'};
$balances = "balances";
$lists = "listados";
###REMOVER fin:

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
, "-sa" => 0
, "-sao" => 0
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

			case "-sa" {
				if(defined($outputs)){
					print "No pueden agregarse dos parámetros de salida diferentes\n";
					exit;
				}
				$i++;
				@outputs = ();
				$parameters{"-sa"} = 1;
			}
			case "-sao" {
				if(defined($outputs)){
					print "No pueden agregarse dos parámetros de salida diferentes\n";
					exit;
				}
				$i++;
				@outputs = ();
				$parameters{"-sao"} = 1;
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
	my $showDetails = @_[0];
	@fileNames = sort(@fileNames); #ordeno los archivos por fecha para su tratamiento
	
	my $entity = @_[0];
	my $entityCode = @_[1];

	%balance = ( credit => 0, debit => 0);	
	for($j = 0; $j <= $#fileNames; $j++){
		openInputFile(@fileNames[$j]);
		@lines = <INPUTFILE>;
		close (INPUTFILE);

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

sub openInputFile{
	open(INPUTFILE,"<$tranfer/@_[0]") || die "Error";
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
	if($parameters{"-sa"} || $parameters{"-sao"}){
		my $fileName = getLoggingTime();
		if (!-d "$folder") {
		    make_path $folder or die "Se ha producido un error creando el reporte: $folder. No se guardará el reporte en el archivo indicado.";
		}
		open(OUTPUTFILE,">$folder/$fileName.txt") || die "Error generando el archivo de salida. No se guardará el reporte en el archivo indicado.";
		push(@outputs, OUTPUTFILE);
		print "El reporte se guardará en el archivo: $fileName\n";
	}
	if($parameters{"-sao"} || !$parameters{"-sa"}){
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


sub pedirFiltros{
	while($filtro ne "x"){
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

getParameters(); #Otengo los parametros

showParameters(); #Muestro los parametros

getFileNames(); #Obtengo los archivos a utilizar

showFileNames(); #Muestro los archivos fuente que fueron encontrados segun los filtros

#listByCbu("0030032120005404458661");


#listByDestinationEntity(1);
listByOriginEntity(0);
#balanceByEntity("BAPRO", "003");

