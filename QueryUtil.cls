/*
 * Static methods to extend standard SOQL query capabilities.
 *
 * @author: Luke
 * @date: Dec 2012
 */
public class QueryUtil {

	public class QueryException extends Exception {}

	/*
	 * Return query results as list of sObjects. 
	 * Transform query string if it is in format "Select * From ..."
	 */
	public static List<sObject> query(String query) {
		List<sObject> result = new List<sObject>();

		System.debug('About to transform query string: ' + query);
		String queryStr = getTransformedQueryStr(query);
		System.debug('About to perform query: ' + queryStr);

		result = Database.query(queryStr);
		System.debug('Returning ' + result.size() + ' result(s)...');

		return result;
	}

	/*
	 * Given a query string, replace * with comma-delimited list of all fields. 
	 * If not in format "Select * From..." just return the same string.
	 */
	public static String getTransformedQueryStr(String query) {
		String result = '';

		String regex = '^select\\s+\\*\\s+from\\s+([^\\s]+)(.*)$';
		Matcher m = Pattern.compile(regex).matcher(query.toLowerCase());
		if(m.matches()) {
			System.debug('Query matched against regular expression successfully');

			String sObjectName = m.group(1);
			System.debug('sObject name: ' + sObjectName);

			Schema.SObjectType targetType = Schema.getGlobalDescribe().get(sObjectName);
			Map<String, Schema.SObjectField> fieldMap = targetType.getDescribe().fields.getMap();

			List<String> fieldList = new List<String>();
			fieldList.addAll(fieldMap.keyset());
			String allFields = String.join(fieldList, ', ');
			System.debug('Have field list: ' + allFields);

			result = query.replace('*', allFields);

		} else {
			System.debug('Either query string not in correct format or doesnt need transforming');
			result = query;
		}

		return result;
	}
}

