param([string] $clientId,
      [string] $clientSecret)

function Do-Insertion(
    $component,
    $queueName,
    $fromBranch,
    $toBranch,
    $insertCore="true",
    $insertDevdiv="true",
    $updatecorextlibraries="false",
    $updateassemblyversions="false",
    $insertToolset="false",
    $queueValidation="true",
    $dropPath="",
    $titlePrefix="[Auto Insertion]")
{
    Write-Host "Performing $component $fromBranch Insertion into $toBranch..."

    $toolsetFlag = ""
    if ($insertToolset -eq "true") {
        $toolsetFlag = "/t"
    }

    $dropPathFlag = ""
    if ($dropPath) {
        $dropPathFlag = "/dp=$dropPath"
    }

    & $PSScriptRoot\RIT.exe "/in=$component" "/bn=$fromBranch" "/vsbn=$toBranch" "/bq=$queueName" /ic=$insertCore /uc=$updatecorextlibraries /ua=$updateassemblyversions /id=$insertDevdiv /qv=$queueValidation "/ci=$clientId" "/cs=$clientSecret" "/tp=$titlePrefix" $toolsetFlag $dropPathFlag
}

###
### F# Insertions (handled by the F# team)
###

#Do-Insertion -component "F#" -queueName "FSharp-Signed" -fromBranch "dev15.8" -toBranch "rel/d15.8"    -insertCore "false" -insertDevdiv "false" -queueValidation "true" -dropPath "\\cpvsbuild\drops\FSharp"
#Do-Insertion -component "F#" -queueName "FSharp-Signed" -fromBranch "dev15.9" -toBranch "rel/d15.9" -insertCore "false" -insertDevdiv "false" -queueValidation "true" -dropPath "\\cpvsbuild\drops\FSharp"
# disabled until RPS tests are reliable again
#Do-Insertion -component "F#" -queueName "FSharp-Signed" -fromBranch "dev16.0" -toBranch "lab/d16.0stg"    -insertCore "false" -insertDevdiv "false" -dropPath "\\cpvsbuild\drops\FSharp"
#Do-Insertion -component "F#" -queueName "FSharp-Signed" -fromBranch "dev16.1" -toBranch "lab/ml"    -insertCore "false" -insertDevdiv "false" -dropPath "\\cpvsbuild\drops\FSharp"

###
### Unit Testing Insertions
###

# Dev 16.3 Preview 2
Do-Insertion -component "VS Unit Testing"    -queueName "VSUnitTesting-Signed"  -fromBranch "master"  -toBranch "master"  -insertCore "true"   -queueValidation "true"  -dropPath "server"
Do-Insertion -component "Live Unit Testing"  -queueName "TestImpact-Signed"     -fromBranch "master"  -toBranch "master"  -insertCore "false"  -insertDevdiv "false"    -queueValidation "true"

###
### Roslyn Insertions
###

#Do-Insertion -component "Roslyn"  -queueName "Roslyn-Signed"  -fromBranch "dev15.8.x-vs-deps"        -toBranch "rel/d15.8"  -insertToolset "false"  -insertDevdiv "false"  -updatecorextlibraries "true"  -queueValidation "true"
#Do-Insertion -component "Roslyn"  -queueName "Roslyn-Signed"  -fromBranch "dev15.9.x-vs-deps"        -toBranch "rel/d15.9"  -insertToolset "false"  -insertDevdiv "false"  -updatecorextlibraries "true"  -queueValidation "true"
#Do-Insertion -component "Roslyn"  -queueName "Roslyn-Signed"  -fromBranch "dev16.0-vs-deps"          -toBranch "rel/d16.0"  -insertToolset "false"  -insertDevdiv "false"  -updatecorextlibraries "true"  -queueValidation "true"
#Do-Insertion -component "Roslyn"  -queueName "Roslyn-Signed"  -fromBranch "release/dev16.3-vs-deps"  -toBranch "rel/d16.3"  -insertToolset "false"  -insertDevdiv "false"  -updatecorextlibraries "true"  -queueValidation "true"

# Dev 16.4 Previews - Disabled while testing insertion on successful Signed Build
#Do-Insertion -component "Roslyn"  -queueName "Roslyn-Signed"  -fromBranch "release/dev16.4-preview1-vs-deps"  -toBranch "rel/16.4"  -insertToolset "false"  -insertDevdiv "false"  -updatecorextlibraries "true"  -queueValidation "true"
#Do-Insertion -component "Roslyn"  -queueName "Roslyn-Signed"  -fromBranch "master-vs-deps"                    -toBranch "master"    -insertToolset "true"   -insertDevdiv "false"  -updatecorextlibraries "true"  -queueValidation "true"
