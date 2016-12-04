// Foundation JavaScript
// Documentation can be found at: http://foundation.zurb.com/docs

$(document).ready(function(){
    fin.desktop.main(function(){
        //installAddIn();
    });
});
$("#installbutton").click(function(){
    fin.desktop.main(function(){
		installAddIn();
    });
});


function installAddIn() {
    fin.desktop.System.launchExternalProcess({
        alias: 'embonds-addin',
        target: 'InstallAddIn.vbs',
        listener: function (args) {
            console.log('Installer script completed!');
			console.log(args);

            if (args.exitCode == 0) {

                fin.desktop.System.launchExternalProcess({
                    alias: "embonds-addin",
                    target: "TR-Eurobonds-Enable-Macros.xlsm",
                    listener: function(code) {
                            console.log('the exit code', code);
                        }
                    },
                    function() {
                        console.log('Excel launched');
                    },
                    function(){
                        console.log('Error in launching Excel');
                    });

            }
        }
    });
}


