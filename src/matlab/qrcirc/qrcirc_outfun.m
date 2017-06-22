function status = qrcirc_outfun(t,y,flag)

switch(flag)
  case []
    status = 1;
  otherwise
    status = 0;
end
