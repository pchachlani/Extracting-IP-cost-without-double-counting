
data out.want;
	if _n_=1 then do;
		declare hash h (ordered:"y");
		declare hiter hi ("h");
		h.definekey("date");
		h.definedata("date");
		h.definedone();
	end;

	do until (last.id);
		set out.have;
		by id;

		do date= start to end;
			h.ref();
		end;
	end;

	rc=hi.first();

	do i=1 by 1 while (rc=0);
		if i=1 then do;
			_start=date;
			_date=date;
		end;
		else do;
			if _date+1 ne date then do;
				_end=_date;
				output;
				_start=date;
			end;
				_date=date;
			end;
			rc=hi.next();
		end;
		_end=date;
		output;

		h.clear();

		keep id _start _end;
		format _start _end mmddyy10.;
	end;




