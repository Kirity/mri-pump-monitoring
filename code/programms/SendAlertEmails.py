try:
    tableName = 'Temperature'
    alertName = 'Temperature'
    colName = 'TEMPERATURE_ALERT'
    Type_ID = conf.get('MeasureTypes','Temperature_TypeID')
    print 'Executing ','ExecuteAlertEmail.py'
    execfile(conf.get('code', 'codeLoc')+'ExecuteAlertEmail.py')

    tableName = 'Pressure'
    alertName = 'Pressure'
    colName = 'PRESSURE_ALERT'
    Type_ID = conf.get('MeasureTypes','Pressure_TypeID')
    print 'Executing for pressure '
    execfile(conf.get('code', 'codeLoc')+'ExecuteAlertEmail.py')
except Exception as  ex:
    print ex
