function theta = choose_solution(all_thetas,cur_theta)  

    if size(all_thetas,1) == 0
        theta = cur_theta;
    else
            lct = cur_theta >= 0;
            lpt = all_thetas>= 0;
            slt = lpt == lct;
            slt = sum(slt,2);
            lit = slt >= 4;
            if sum(lit) == 1
                theta = all_thetas(lit,:);
            elseif sum(lit) == 2
                all_thetas = all_thetas(lit,:);
                diff = abs(cur_theta - all_thetas);
                [~,ld] = min(diff);
                l1d = ld == 1;
                l2d = ld == 2;
                if sum(l1d) >sum(l2d)
                    theta = all_thetas(1,:);
                else
                    theta = all_thetas(2,:);
                end
            else 
                theta = all_thetas(end-1,:);
            end   
    end
end