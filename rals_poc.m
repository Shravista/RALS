function [duration,x,y,z,phi,theta,psi,r,g,b] = rals_poc(t)
%% define persistent variables
persistent xvia yvia zvia phivia thetavia psivia rvia gvia bvia
persistent trajectorytypevia tipspeed tvia dur
%% Handle Initialization

    if nargin == 0
        pickPainting = randi(4);
       if pickPainting == 1
           load circle painting
       elseif pickPainting == 2
           load circle2 painting
       elseif pickPainting == 3
           load eiffel painting
       else
            load manit painting
       end
       % load manit painting
        xvia = painting(:,1);
        yvia = painting(:,2);
        zvia = painting(:,3);
        phivia   = painting(:,4);
        thetavia = painting(:,5);
        psivia   = painting(:,6);
        rvia = painting(:,7);
        gvia = painting(:,8);
        bvia = painting(:,9);
        trajectorytypevia = painting(:,10);
        distances = sqrt(diff(xvia).^2 + diff(yvia).^2 + diff(zvia).^2);
        tipspeed = 4;           % define tipspeed
        durations = distances/tipspeed;
        tvia = cumsum(durations);
        tvia = [0;tvia];
        dur  = tvia(end);
        duration = dur;
        return
    end
    %% Handle regular calls
    duration = dur;
    traj = find(t < tvia,1) - 1;
    switch(trajectorytypevia(traj))
        case 1 % change it always
            x = linear_trajectory(t,tvia(traj),tvia(traj+1),xvia(traj),xvia(traj+1));
            y = linear_trajectory(t,tvia(traj),tvia(traj+1),yvia(traj),yvia(traj+1));
            z = linear_trajectory(t,tvia(traj),tvia(traj+1),zvia(traj),zvia(traj+1));
            phi = linear_trajectory(t,tvia(traj),tvia(traj+1),phivia(traj),phivia(traj+1));
            theta = linear_trajectory(t,tvia(traj),tvia(traj+1),thetavia(traj),thetavia(traj+1));
            psi = linear_trajectory(t,tvia(traj),tvia(traj+1),psivia(traj),psivia(traj+1));
            r = linear_trajectory(t,tvia(traj),tvia(traj+1),rvia(traj),rvia(traj+1));
            g = linear_trajectory(t,tvia(traj),tvia(traj+1),gvia(traj),gvia(traj+1));
            b = linear_trajectory(t,tvia(traj),tvia(traj+1),bvia(traj),bvia(traj+1));
        case 2
            x = linear_trajectory(t,tvia(traj),tvia(traj+1),xvia(traj),xvia(traj+1));
            y = linear_trajectory(t,tvia(traj),tvia(traj+1),yvia(traj),yvia(traj+1));
            z = linear_trajectory(t,tvia(traj),tvia(traj+1),zvia(traj),zvia(traj+1));
            phi = linear_trajectory(t,tvia(traj),tvia(traj+1),phivia(traj),phivia(traj+1));
            theta = linear_trajectory(t,tvia(traj),tvia(traj+1),thetavia(traj),thetavia(traj+1));
            psi = linear_trajectory(t,tvia(traj),tvia(traj+1),psivia(traj),psivia(traj+1));
            r = linear_trajectory(t,tvia(traj),tvia(traj+1),rvia(traj),rvia(traj+1));
            g = linear_trajectory(t,tvia(traj),tvia(traj+1),gvia(traj),gvia(traj+1));
            b = linear_trajectory(t,tvia(traj),tvia(traj+1),bvia(traj),bvia(traj+1));
        case 3 
            x = linear_trajectory(t,tvia(traj),tvia(traj+1),xvia(traj),xvia(traj+1));
            y = linear_trajectory(t,tvia(traj),tvia(traj+1),yvia(traj),yvia(traj+1));
            z = linear_trajectory(t,tvia(traj),tvia(traj+1),zvia(traj),zvia(traj+1));
            phi = linear_trajectory(t,tvia(traj),tvia(traj+1),phivia(traj),phivia(traj+1));
            theta = linear_trajectory(t,tvia(traj),tvia(traj+1),thetavia(traj),thetavia(traj+1));
            psi = linear_trajectory(t,tvia(traj),tvia(traj+1),psivia(traj),psivia(traj+1));
            r = linear_trajectory(t,tvia(traj),tvia(traj+1),rvia(traj),rvia(traj+1));
            g = linear_trajectory(t,tvia(traj),tvia(traj+1),gvia(traj),gvia(traj+1));
            b = linear_trajectory(t,tvia(traj),tvia(traj+1),bvia(traj),bvia(traj+1));
        case 4
            x = linear_trajectory(t,tvia(traj),tvia(traj+1),xvia(traj),xvia(traj+1));
            y = linear_trajectory(t,tvia(traj),tvia(traj+1),yvia(traj),yvia(traj+1));
            z = linear_trajectory(t,tvia(traj),tvia(traj+1),zvia(traj),zvia(traj+1));
            phi = linear_trajectory(t,tvia(traj),tvia(traj+1),phivia(traj),phivia(traj+1));
            theta = linear_trajectory(t,tvia(traj),tvia(traj+1),thetavia(traj),thetavia(traj+1));
            psi = linear_trajectory(t,tvia(traj),tvia(traj+1),psivia(traj),psivia(traj+1));
            r = linear_trajectory(t,tvia(traj),tvia(traj+1),rvia(traj),rvia(traj+1));
            g = linear_trajectory(t,tvia(traj),tvia(traj+1),gvia(traj),gvia(traj+1));
            b = linear_trajectory(t,tvia(traj),tvia(traj+1),bvia(traj),bvia(traj+1));   
        otherwise
            error(['Unknown trajectory type: ' num2str(trajectorytypevia(traj))])
    end
end
        
    
    
    
            
        