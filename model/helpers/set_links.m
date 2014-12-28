function set_links(status)
%SET_LINKS Summary of this function coming soon..
%   Detailed explanation coming soon..
%
%	Copyright © 2014 Alexander Isakov. Contact: <alexander.isakov@tuhh.de>
%	Copyright © 2014 Marina Krotofil. Contact: <marina.krotofil@tuhh.de>
%	Copyright © 2014 TUHH-SVA Security in Distributed Applications.
%	All rights reserved.
%	License: http://opensource.org/licenses/BSD-3-Clause
%	----------------------------------------------------------------------

    xmvs = 1:26;
    xmeas = 1:43;
    for i = xmeas
        set_link([bdroot '/VA Plant/xmeas atk block/xmeas' num2str(i) ' attack controller'], status);
    end
    for i = xmvs
        set_link([bdroot '/VA Plant/xmv atk block/xmv' num2str(i) ' attack controller'], status);
    end
end

