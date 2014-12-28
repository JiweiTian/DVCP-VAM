classdef ControllerProperties
%CONTROLLERPROPERTIES Summary of this class coming soon..
%   Detailed explanation coming soon..
%
%	Copyright © 2014 Alexander Isakov. Contact: <alexander.isakov@tuhh.de>
%	Copyright © 2014 Marina Krotofil. Contact: <marina.krotofil@tuhh.de>
%	Copyright © 2014 TUHH-SVA Security in Distributed Applications.
%	All rights reserved.
%	License: http://opensource.org/licenses/BSD-3-Clause
%	----------------------------------------------------------------------

    properties
        String
        Value
    end
    
    methods
        function this = ControllerProperties(string, value)
            this.String = string;
            this.Value = value;
        end
    end
    
    enumeration
        TYPE('ctype', 1)
        GAIN('gain', 2)
        RESETTIME('reset', 3)
        SETPOINT('Value', 4)
    end
end

