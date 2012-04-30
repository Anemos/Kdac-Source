-- file name : pbbpm.sf_bpm_005
-- function name : pbbpm.sf_bpm_005
-- desc : 사급완성품 하위레벨의 재료비 합계구하기

drop   function  pbbpm.sf_bpm_005 ;
create function  pbbpm.sf_bpm_005(
   a_comltd            varchar(2),
   a_xyear             varchar(4),
   a_rev               varchar(2),
   a_gubun             varchar(1),
   a_plant             varchar(1),
   a_div               varchar(1),
   a_mdcd              varchar(4),
   a_mdno              varchar(12),
   a_pchno             varchar(12),
   a_serl              varchar(600))
   returns             numeric(13,6)
   language sql
   modifies sql data
   begin
      declare ld_amtsum  numeric(13,6);
      declare p_serl varchar(600);
      declare sqlcode    integer default 0 ;

      set p_serl = concat(trim(a_serl),'%');

      select sum( decimal(case when tmp.cls <> '50' and
          (tmp.bcalc = 'Y' or tmp.bwoct = '8888') then
           tmp.curdcst / tmp.conv_factor * tmp.bprqt
           else 0 end,13,6) )
      into ld_amtsum
      from (select dd.cls,bb.bcalc,bb.bwoct,bb.bprqt,dd.srce,
      // 외자적용기준단가
      case when dd.cls = '10' or dd.cls = '20' or dd.cls = '40' or
              dd.cls = '50' or dd.cls = '35' then
      case when ( dd.srce = '05' or dd.srce = '06' ) or dd.cls = '30' then 0
      else
       case when (dd.srce = '03' and bb.bwoct <> '8888') then 0
       else
       case when dd.srce <> '01' then
          case when cc.ycste = 0 then
        case when bb.bygchk = 'Y' then // 유상사급완성품
          cc.ygcst
        else
          cc.ycstd
        end
       else
        case when bb.bygchk = 'Y' then // 유상사급완성품
          cc.ygcst
        else
          cc.ycste
        end
        end
        else
         case when bb.bygchk = 'Y' then // 유상사급완성품
        cc.ygcst
       else
        cc.ycste
       end
       end
     end
     end
     else 0 end as curecst,
     // 내자적용기준단가
     case when dd.cls = '10' or dd.cls = '20' or dd.cls = '40' or
           dd.cls = '50' or dd.cls = '35' then
     case when ( dd.srce = '05' or dd.srce = '06' ) or dd.cls = '30' then 0
     else
     case when (dd.srce = '03' and bb.bwoct <> '8888') then 0
      else
      case when dd.srce <> '01' then
            case when cc.ycstd = 0 then
          case when bb.bygchk = 'Y' then // 유상사급완성품
            cc.ygcst
          else
            cc.ycste
          end
        else
          case when bb.bygchk = 'Y' then // 유상사급완성품
            cc.ygcst
          else
            cc.ycstd
          end
        end
          else
        case when bb.bygchk = 'Y' then // 유상사급완성품
          cc.ygcst
        else
          cc.ycstd
        end
      end
    end
    end
    else 0 end as curdcst,
    // 변환계수
    cc.convqty as conv_factor
    from pbbpm.bpm508 bb inner join pbbpm.bpm503 dd
     on bb.xyear = dd.xyear and bb.brev = dd.revno and
     bb.balcd = dd.xplant and bb.baldiv = dd.div and bb.bchno = dd.itno
    inner join pbbpm.bpm509 cc
    on bb.xyear = cc.yccyy and bb.brev = cc.revno and
       bb.bchno = cc.yitno and
       cc.ygubun = '10' and cc.ygrad = '1'
    where bb.comltd = a_comltd and bb.xyear = a_xyear and
      bb.brev = a_rev and bb.bgubun = a_gubun and
      bb.bplant = a_plant and bb.bdiv = a_div and
      bb.bmdcd = a_mdcd and bb.bmdno = a_mdno and
      bb.bprno = a_pchno and bb.blev <> 0 and
      bb.extd like p_serl) tmp;

   return ifnull(ld_amtsum,0);

   end
