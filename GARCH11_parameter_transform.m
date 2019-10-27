function outparv=GARCH11_parameter_transform(inparv,direction)
% function to transform parameter in GARCH(1,1)
nh=length(inparv)-3;
if direction
    theta=inparv;
    theta(nh+1)=exp(inparv(nh+1));
    [theta(nh+2:end),lnjac]=BetaTransform(inparv(nh+2:end),1);
    outparv=theta;
else
    eta=inparv;
    eta(nh+1)=log(inparv(nh+1));
    [eta(nh+2:end),lnjac]=BetaTransform(inparv(nh+2:end),0);
    outparv=eta;
end
