% Commands
% clear smu
% smu = B2901A_Adapter();
% smu.getDeviceInfo()

classdef B2901A_Adapter < handle
    %B2901A_Adapter  Matlab Aapter class for Keysoght B2901A (.NET 8
    %driver)

    properties
        Controller
        AsmInfo
    end

    methods
        function obj = B2901A_Adapter(resource)
            %B2901A_ADAPTER Construct an instance of this class
            %   Detailed explanation goes here
            arguments
                resource(1,1) string = "";
            end
            if dotnetenv().Status == "notloaded"
                dotnetenv("core");
            end
            classDir = fileparts(mfilename("fullpath"));
            binDir = fullfile(classDir, 'bin');
            NET.addAssembly(fullfile(binDir, 'Ivi.Visa.dll'));
            NET.addAssembly(fullfile(binDir, 'Keysight.Visa.dll'));
            obj.AsmInfo = NET.addAssembly(fullfile(binDir, 'classLibB2901.dll'));
            if strlength(resource) == 0
                obj.Controller = classLibB2901.B2901AController();
            else
                obj.Controller = classLibB2901.B2901AController(resource);
            end
        end

        function idn = getDeviceInfo(obj)
            idn = string(obj.Controller.GetDeviceInfo()).strip()
        end
    end
end