package com.maven.util;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.TimeZone;

import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;

/**
 * JSON转换工具类。
 * 
 * @author sum
 *
 */
@SuppressWarnings("all")
public class JsonUtils {
	private static org.slf4j.Logger logger = LoggerFactory.getLogger(JsonUtils.class);
	private static ObjectMapper objectMapper;

	static {
		objectMapper = new ObjectMapper();
		// 去掉默认的时间戳格式
		objectMapper.configure(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS, false);
		// 设置为中国上海时区
		objectMapper.setTimeZone(TimeZone.getTimeZone("GMT+8"));
		objectMapper.configure(SerializationFeature.WRITE_NULL_MAP_VALUES, false);
		// 空值不序列化
		objectMapper.setSerializationInclusion(Include.NON_NULL);
		// 反序列化时，属性不存在的兼容处理
		objectMapper.getDeserializationConfig().withoutFeatures(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
		// 序列化时，日期的统一格式
		objectMapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));

		objectMapper.configure(SerializationFeature.FAIL_ON_EMPTY_BEANS, false);
		objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		// 单引号处理
		objectMapper.configure(com.fasterxml.jackson.core.JsonParser.Feature.ALLOW_SINGLE_QUOTES, true);
	}

	/**
	 * 获取ObjectMapper对象。
	 * 
	 * @return 返回ObjectMapper对象。
	 */
	public static ObjectMapper getObjectMapper() {
		if (objectMapper == null) {
			objectMapper = new ObjectMapper();
		}
		return objectMapper;
	}

	/**
	 * JSON字符串转Bean对象。
	 * 
	 * @param json
	 * @param clazz
	 * @return 返回泛型对象。
	 */
	public static <T> T toBean(String json, Class<T> clazz) {
		try {
			return objectMapper.readValue(json, clazz);
		} catch (JsonParseException e) {
			logger.error(e.getMessage(), e);
		} catch (JsonMappingException e) {
			logger.error(e.getMessage(), e);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
		return null;
	}

	/**
	 * Bean转JSON串。
	 * 
	 * @param entity
	 * @return 返回json字符串。
	 */
	public static <T> String toJson(T entity) {
		try {
			return objectMapper.writeValueAsString(entity);
		} catch (JsonGenerationException e) {
			logger.error(e.getMessage(), e);
		} catch (JsonMappingException e) {
			logger.error(e.getMessage(), e);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
		return null;
	}

	/**
	 * JSON字符串中集合。
	 * 
	 * @param json
	 * @param typeReference
	 * @return 返回泛型集合。
	 */
	public static <T> T toCollection(String json, TypeReference<T> typeReference) {
		try {
			return objectMapper.readValue(json, typeReference);
		} catch (JsonParseException e) {
			logger.error(e.getMessage(), e);
		} catch (JsonMappingException e) {
			logger.error(e.getMessage(), e);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		}
		return null;
	}
}
