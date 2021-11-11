$date_regex='20[0-9][0-9][0-1][0-9][0-3][0-9]';
$hour_regex='[0-2][0-9][0-5][0-9]';
function has_date() {
    param(
        $filename
    )
    return $filename -match '^'+$date_regex+'_*.*' 
}

function has_hour() {
    param(
        $filename
    )

    $res = $filename -match '^'+$date_regex+'_'+$hour_regex+'_*.*';
    return $res;
}

function extract_date() {
    param(
        $filename
    )
    $res = ($filename -split '_')[0];
    Write-Host $res
    return $res
}

function extract_hour() {
    param(
        $filename
    )
    return ($filename -split '_')[1];
}

function replace_date() {
    param(
        $dateFilename
    )
    
    # precalcul de la date
    $today=Get-Date -Format 'yyyyMMdd';
    # si le nom contient une date au debut
    if (has_date($dateFilename)) {
        # precalcul de l'heure
        $now=Get-Date -Format 'HHmm';
        # si le nom contient deja la date du 
        Write-Host $today
        $test=((extract_date($dateFilename)) -eq $today);
        Write-Host $test
        if($test) {
            # si il y a aussi une heure indiquee
            if(has_hour($dateFilename)) {
                $tobereplaced=$today+'_'+$hour_regex;
                $toinsert=$today+'_'+$now
                Write-Host $result
            # si pas d'heure, la rajouter
            } else {
                $tobereplaced=$today;
                $toinsert=$today+'_'+$now;
            }
            $result=$dateFilename -replace $tobereplaced,$toinsert
            Write-Host $result
        # 
        } else {
            $result=$dateFilename -replace $date_regex,$today
        }
    # cas ou pas de date au debut du nom de fichier
    } else {
        $result=$today+"_"+$dateFilename
    }
    return $result
}

$filepath=$args[0];

$outputFile=Split-Path $filepath -leaf
$outputFolder=Split-Path $filepath
$outputFileName=replace_date($outputFile);

$destination=Join-Path -Path $outputFolder -ChildPath $outputFileName
$nb_count=0;
While((Test-Path $destination -PathType leaf) -and ($nb_count -lt 2)) {
    $outputFileName=replace_date($outputFileName);
    $destination=Join-Path -Path $outputFolder -ChildPath $outputFileName
    $nb_count++;
}

If($nb_count -gt 1) {
    Add-Type -AssemblyName PresentationFramework
    [System.Windows.MessageBox]::Show($outputFileName+' already exists!','Alert');
    exit
}

Copy-Item $filepath -Destination $destination;