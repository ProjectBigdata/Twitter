/**
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package nl.utwente.bigdata;

import java.io.IOException;
import java.util.Map;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.GenericOptionsParser;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;


public class TwitterR {

  public static class TwitterMapper 
       extends Mapper<Object, Text, Text, Text>{
    
    private Text idString  = new Text();
    private Text tweetDetail = new Text();
    private JSONParser parser = new JSONParser();
    private Map<String, Object> tweet;
    
    @SuppressWarnings("unchecked")
	public void map(Object key, Text value, Context context) throws IOException, InterruptedException {

      try {
        tweet = (Map<String, Object>) parser.parse(value.toString());
      }
      catch (ClassCastException e) {  
        return; // do nothing (we might log this)
      }
      catch (org.json.simple.parser.ParseException e) {  
        return; // do nothing 
      }

      Map<String, Object> user = (Map<String, Object>) tweet.get("user");
      Map<String, Object> geo = (Map<String, Object>) tweet.get("geo");
      String userId = (String) user.get("id_str");       
      if(geo != null){
    	  idString.set((String) tweet.get("id_str"));
          String tweetText = ((String) tweet.get("text")).replaceAll("\n", " ");
          String name = (String) user.get("name"); 
          JSONArray coordinates = (JSONArray) geo.get("coordinates");
          String createdAt = (String) tweet.get("created_at");
          String latitude = coordinates.get(0).toString();
          String longitude = coordinates.get(1).toString();
          String detail = userId + "\t" + name + "\t" + latitude + "\t" + longitude + "\t" + createdAt + "\t" + tweetText ;
          tweetDetail.set(detail);
          context.write(idString, tweetDetail);
      }
    }
  }
  
  public static class TwitterReducer 
       extends Reducer<Text, Text, Text, Text> {

    public void reduce(Text key, Iterable<Text> values, 
                       Context context
                       ) throws IOException, InterruptedException {
      for (Text value : values) {
        context.write(key, value);
      }
    }
  }

  public static void main(String[] args) throws Exception {
    Configuration conf = new Configuration();
    String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
    if (otherArgs.length < 2) {
      System.err.println("Usage: exampleTwitter <in> [<in>...] <out>");
      System.exit(2);
    }
    @SuppressWarnings("deprecation")
	Job job = new Job(conf, "TwitterR");
    job.setJarByClass(TwitterR.class);
    job.setMapperClass(TwitterMapper.class);
    job.setReducerClass(TwitterReducer.class);
    
    job.setOutputKeyClass(Text.class);
    job.setOutputValueClass(Text.class);
    for (int i = 0; i < otherArgs.length - 1; ++i) {
      FileInputFormat.addInputPath(job, new Path(otherArgs[i]));
    }
    FileOutputFormat.setOutputPath(job,
      new Path(otherArgs[otherArgs.length - 1]));
    System.exit(job.waitForCompletion(true) ? 0 : 1);
  }
}
