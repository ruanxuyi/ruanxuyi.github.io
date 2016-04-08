`getSharedPreferences(String name, int mode)`

takes following parameters:   
1. String name: each name corresponding to one unique SharedPreferences instance. Within each the instance, you can stores various <key, value> pairs. 
2. int mode: operating mode: 0 for MODE_PRIVATE, etc
3. getSharedPreferences() is used when you need multiple preferences. If ONLY one preference is needed, use `getPreference()` instead.


## Read from the sharePerference: 
1. get the corresponding sharedPerference instance
2. use ｀getString(key, " ")｀ the ｀key｀ to find the ｀value｀ from that specific instance


## Write to the sharePerference: 
1. get the corresponding sharedPerference instance.
2. Call edit() to get a SharedPreferences.Editor: 


```
	SharedPreferences.Editor mEditor = mPrefs.edit()
```

All changes you make in an editor are batched, and not copied back to the original SharedPreferences until you call `commit()` or `apply()`


3. mEditor.clear()


4. mEditor.putString(key, value)

Add values with methods such as putBoolean() and putString()


NOT need to call commit()????



