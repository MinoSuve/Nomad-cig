## Update(s)

## Info
- Useable item called "shikarice","cigarttee"
- Cigarette Packs has 20 cigarettes inside
- Use the pack of cigs to get a single cigarette out of it
- Use the cigarette for minor, legal stress relief
- Pack deletes itself when the last cigarette is removed

## Dependencies
- ox_inventory
- ox_lib
- qb-policejob

## Insert into ox_inventory:data:items.lua:
```
['sikharice pack'] = { -- do not change the name of item 
    label = 'sikharice',
    weight = 500,
    client = {
         event = 'Nomad-cig:client:UseCigPack',
         image = 'sikharice'
    },
	description = "Shikar ice ",
	consume=0.01,
    stack = false
},
['cigarette'] = {
    label = 'cigarettes',
    weight = 50,
    client = {
         event = 'Nomad-cig:client:UseCig444',
    },
	description = "Smells like Tobacco",
    stack = true
},
```


## Insert into qb-policejob:client:evidence.lua (no real meaning, just a new status effect)

Under local StatusList
```
['tobaccosmell'] = Lang:t('evidence.tobacco_smell'),
```

## Insert into qb-policejob:locales:en.lua (no real meaning, just a new status effect)

Under evidence
```
tobacco_smell = 'Smells like tobacco',
```

## 
