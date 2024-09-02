import React, { useState, useEffect, useRef } from "react";

interface AutoResizableImageProps {
  src: string;
  alt: string;
  className?: string;
}

const AutoResizableImage: React.FC<AutoResizableImageProps> = ({
  src,
  alt,
  className,
}) => {
  const [dimensions, setDimensions] = useState({ width: 0, height: 0 });
  const containerRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const handleResize = () => {
      if (containerRef.current) {
        const { clientWidth, clientHeight } = containerRef.current;
        setDimensions({ width: clientWidth, height: clientHeight });
      }
    };

    handleResize();
    window.addEventListener("resize", handleResize);

    return () => {
      window.removeEventListener("resize", handleResize);
    };
  }, []);

  return (
    <div ref={containerRef} className={`relative ${className}`}>
      <img
        src={src}
        alt={alt}
        style={{
          width: dimensions.width,
          height: dimensions.height,
          objectFit: "cover",
        }}
        className="absolute inset-0"
      />
    </div>
  );
};

export default AutoResizableImage;
